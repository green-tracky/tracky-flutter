// lib/services/fcm_service.dart

import 'dart:convert'; // JSON 데이터를 다루기 위해 필요한 라이브러리입니다.

import 'package:dio/dio.dart'; // Dio 패키지에서 제공하는 예외 클래스(DioException)를 사용하기 위해 필요합니다.
import 'package:firebase_messaging/firebase_messaging.dart'; // Firebase Cloud Messaging(FCM)을 사용하기 위한 핵심 패키지입니다.
import 'package:flutter/material.dart'; // Flutter의 UI 위젯과 네비게이션 기능을 사용하기 위해 필요합니다.
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // 앱이 실행 중일 때(포그라운드) 알림을 직접 띄워주기 위한 패키지입니다.
import 'package:tracky_flutter/_core/utils/my_http.dart'; // 2단계에서 만든, 서버와 통신을 담당하는 Dio 클라이언트를 가져옵니다.

// [매우 중요] 백그라운드 메시지 핸들러는 반드시 클래스 바깥에 있는 최상위(top-level) 함수여야 합니다.
// 앱이 꺼져있거나 백그라운드에 있을 때, Flutter 엔진이 이 함수를 직접 찾아 실행하기 때문입니다.
@pragma('vm:entry-point') // 이 코드가 반드시 컴파일에 포함되어야 한다고 컴파일러에게 알려주는 역할입니다. (없으면 릴리즈 모드에서 제거될 수 있음)
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 이 함수는 UI와 관련 없는 독립적인 공간에서 실행되므로,
  // 여기서 UI를 직접 제어하는 코드를 넣으면 안 됩니다.
  // 주로 받은 데이터를 로컬 DB에 저장하거나, 로그를 남기는 용도로 사용합니다.
  print("백그라운드 메시지 수신 (ID: ${message.messageId})");
}

/// FCM 관련된 모든 기능을 담당하는 서비스 클래스입니다.
/// 이 클래스 하나로 FCM 초기화, 메시지 수신, 알림 표시, 서버 통신까지 모두 처리합니다.
class FcmService {
  // FirebaseMessaging의 공식 인스턴스(객체)를 가져옵니다. FCM 기능의 시작점입니다.
  final _firebaseMessaging = FirebaseMessaging.instance;

  // [핵심] 네비게이터 키(Navigator Key)
  // 이 키는 MaterialApp에 장착되어, 앱의 어느 곳에서든(심지어 이 서비스 클래스 안에서도)
  // 화면을 이동시키거나(push), 팝업을 띄우는(dialog) 등의 네비게이션 작업을 할 수 있게 해주는 만능 열쇠입니다.
  // 알림을 탭했을 때 특정 화면으로 바로 이동시키기 위해 반드시 필요합니다.
  final GlobalKey<NavigatorState> navigatorKey;

  // 생성자(Constructor): FcmService 객체를 만들 때 반드시 navigatorKey를 전달받도록 합니다.
  FcmService({required this.navigatorKey});

  // 로컬 알림을 사용하기 위한 플러그인 인스턴스입니다.
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  /// 로컬 알림 플러그인을 초기화하는 내부 함수입니다.
  Future<void> _initializeLocalNotifications() async {
    // 안드로이드용 알림 채널을 생성합니다. Android 8.0 이상부터는 알림을 채널별로 관리해야 합니다.
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // 채널의 고유 ID
      '중요 알림', // 사용자에게 보여질 채널 이름
      description: '중요한 공지나 친구 요청 등을 위한 알림 채널입니다.', // 채널 설명
      importance: Importance.high, // 알림의 중요도 (높을수록 사용자에게 잘 보임)
    );
    // 위에서 정의한 채널을 시스템에 등록합니다.
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 각 플랫폼(Android, iOS)별로 알림 초기화 설정을 정의합니다.
    // 'launch_background'는 android/app/src/main/res/drawable 폴더에 있는 아이콘 파일 이름입니다.
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      'launch_background',
    );
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    // 최종적으로 로컬 알림 플러그인을 초기화합니다.
    await _localNotifications.initialize(
      initializationSettings,
      // 로컬 알림을 탭했을 때 호출될 콜백 함수를 지정합니다.
      onDidReceiveNotificationResponse: (details) {
        // 알림에 포함된 데이터(payload)가 있다면
        if (details.payload != null) {
          // JSON 문자열을 다시 Map 형태로 변환(decode)합니다.
          final data = jsonDecode(details.payload!);
          // 알림 상호작용 공통 처리 함수를 호출합니다.
          _handleNotificationInteraction(data);
        }
      },
    );
  }

  /// [공개 메소드] FCM 서비스를 활성화하는 메인 함수입니다.
  ///
  /// main.dart에서 앱이 시작될 때 이 함수 단 하나만 호출하면 모든 설정이 완료됩니다.
  ///
  /// # 메인화면 넘어가기 직전에 실행해야 한다!!!
  Future<void> initialize() async {
    // 1. 사용자에게 알림 수신을 허용할지 묻는 권한 요청 팝업을 띄웁니다. (주로 iOS에서 중요)
    await _firebaseMessaging.requestPermission();

    // 2. 위에서 만든 로컬 알림 초기화 함수를 호출합니다.
    await _initializeLocalNotifications();

    // 3. 현재 기기의 고유한 FCM 토큰을 발급받습니다.
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      // 발급받은 토큰을 우리 서버에 전송하여 저장합니다.
      await saveTokenToServer(fcmToken);
    }
    // 가끔 Firebase가 토큰을 갱신할 때가 있는데, 그럴 때마다 자동으로 새 토큰을 서버에 저장하도록 설정합니다.
    _firebaseMessaging.onTokenRefresh.listen(saveTokenToServer);

    // 4. 앱의 상태(포그라운드, 백그라운드, 종료)에 따라 FCM 메시지를 어떻게 처리할지 설정합니다.
    _setupMessageHandlers();
  }

  /// [공개 메소드] FCM 토큰을 우리 Spring 서버에 저장하는 함수입니다.
  Future<void> saveTokenToServer(String token) async {
    try {
      print("서버에 FCM 토큰 저장 시도: $token");
      // [가정] 현재 로그인된 사용자는 2번이라고 가정합니다. 실제 앱에서는 로그인된 사용자 정보를 사용해야 합니다.
      // 2단계에서 만든 dio 클라이언트를 사용하여 서버 API를 호출합니다.
      await dio.put('/users/jake123/fcm-token', data: {'fcmToken': token});
      print('✅ [역할: jake123] FCM 토큰이 서버에 성공적으로 저장되었습니다.');
    } on DioException catch (e) {
      // Dio를 사용한 네트워크 요청 중 에러가 발생하면 여기서 잡습니다.
      print('❌ [역할: jake123] FCM 토큰 저장 실패: $e');
    }
  }

  /// 앱 상태별 메시지 수신을 처리하는 핸들러들을 설정하는 내부 함수입니다.
  void _setupMessageHandlers() {
    // 1. 앱이 켜져 있는 상태(포그라운드)에서 메시지가 도착했을 때
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('포그라운드 메시지 수신: ${message.notification?.title}');
      // 포그라운드에서는 OS가 알림을 자동으로 띄워주지 않으므로,
      // 우리가 직접 로컬 알림 플러그인을 사용해서 알림을 띄워줍니다.
      _showLocalNotification(message);
    });

    // 2. 앱이 백그라운드에 있을 때, 사용자가 알림을 '탭'했을 때
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: 사용자가 알림을 탭했습니다.');
      // 알림에 담겨온 추가 데이터(data)를 가지고 공통 처리 함수를 호출합니다.
      _handleNotificationInteraction(message.data);
    });

    // 3. 앱이 완전히 종료된 상태에서, 사용자가 알림을 '탭'하여 앱이 실행되었을 때
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('getInitialMessage: 앱이 알림을 통해 실행되었습니다.');
        _handleNotificationInteraction(message.data);
      }
    });
  }

  /// 포그라운드 상태에서 로컬 알림을 직접 화면에 표시하는 내부 함수입니다.
  void _showLocalNotification(RemoteMessage message) {
    // 서버에서 보낸 메시지에 notification 부분이 없으면 아무것도 하지 않습니다.
    final notification = message.notification;
    if (notification == null) return;

    // 로컬 알림 플러그인의 show() 메소드를 사용하여 알림을 띄웁니다.
    _localNotifications.show(
      notification.hashCode, // 알림마다 고유한 ID
      notification.title, // 알림 제목
      notification.body, // 알림 본문
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // 위에서 등록한 채널 ID와 반드시 일치해야 합니다.
          '중요 알림',
          importance: Importance.max, // 중요도를 최대로 설정하여 헤드업 알림으로 표시되게 합니다.
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(presentSound: true, presentBadge: true, presentAlert: true),
      ),
      // 사용자가 이 알림을 탭했을 때, `onDidReceiveNotificationResponse` 콜백에 전달될 데이터입니다.
      // 서버에서 받은 data 페이로드를 JSON 문자열로 변환하여 담습니다.
      payload: jsonEncode(message.data),
    );
  }

  /// 사용자가 알림을 탭했을 때의 동작을 정의하는 공통 처리 함수입니다.
  /// 우리 앱에서는 알림창으로 바로 이동되면 됩니다.
  void _handleNotificationInteraction(Map<String, dynamic> data) {
    navigatorKey.currentState?.pushNamed('/messages', arguments: data);
  }

  /// [공개 메소드] 테스트용으로 친구 요청을 보내는 함수입니다.
  Future<void> sendTestFriendRequest() async {
    try {
      // 서버의 `/friend-requests/send` API로, 수신자 ID가 2번인 친구 요청을 보냅니다.
      // (서버 컨트롤러에서 요청자는 1번으로 하드코딩 되어있습니다)
      await dio.post('/friend-requests/send', data: {'fromId': 2, 'toId': 1});
      print('테스트 친구 요청 전송 성공!');
    } on DioException catch (e) {
      print('테스트 친구 요청 전송 실패: ${e.response?.data}');
    }
  }
}

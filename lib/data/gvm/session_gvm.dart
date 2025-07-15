import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/fcm_service.dart';
import 'package:tracky_flutter/_core/utils/firebase_options.dart';
import 'package:tracky_flutter/main.dart';

final sessionProvider = AutoDisposeNotifierProvider<SessionGVM, SessionModel?>(() {
  return SessionGVM();
});

class SessionGVM extends AutoDisposeNotifier<SessionModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel? build() {
    init();
    return null;
  }


}

Future<void> init() async {
  // 유저 인증 로직

  // Firebase 등록

  // TODO : FCM 초기화 로직 시작 - 3,4,5 번은 순차적으로 동기적으로 수행되야함
  // 3. Firebase 서비스 초기화
  // 이 코드는 현재 실행 중인 플랫폼(웹, 안드로이드, iOS)을 자동으로 감지하고,
  // firebase_options.dart 파일에서 해당 플랫폼에 맞는 설정 값을 가져와 Firebase를 초기화합니다.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 4. 백그라운드 메시지 핸들러 등록
  // FcmService 파일에 정의된 최상위 함수를 여기에 연결해줍니다.
  // 앱이 꺼져있을 때 FCM 메시지를 수신하는 유일한 통로입니다.
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // 5. [핵심] 우리가 만든 FcmService를 초기화합니다.
  // 이 한 줄의 코드가 권한 요청, 토큰 발급/저장, 메시지 리스너 설정 등 모든 것을 처리합니다.
  // 이 때, 위에서 만든 navigatorKey를 전달하여 FcmService가 화면을 제어할 수 있는 권한을 줍니다.
  await FcmService(navigatorKey: navigatorKey).initialize();
  // TODO : FCM 초기화 로직 끝
}

class SessionModel {
  SessionModel();

  SessionModel.fromMap(Map<String, dynamic> data);

  SessionModel copyWith() {
    return this;
  }
}
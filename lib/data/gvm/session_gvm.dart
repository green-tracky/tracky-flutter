import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/fcm_service.dart';
import 'package:tracky_flutter/_core/utils/firebase_options.dart';
import 'package:tracky_flutter/_core/utils/my_http.dart';
import 'package:tracky_flutter/data/model/User.dart';
import 'package:tracky_flutter/data/repository/UserRepository.dart';
import 'package:tracky_flutter/main.dart';


/// 1. 창고 관리자
final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(() {
  // 의존하는 VM

  return SessionGVM();
});

/// 2. 창고 (상태가 변경되어도, 화면 갱신 안함 - watch 하지마)
class SessionGVM extends Notifier<SessionModel> {
  @override
  SessionModel build() {
    return SessionModel();
  }

  Future<void> autoLogin(BuildContext mContext) async {
    await Future.delayed(Duration(seconds: 2));

    // 통신해도 null일 수 있음
    String? idToken = await secureStorage.read(key: "idToken");
    if (idToken == null) {
      Navigator.pushNamed(mContext, "/login"); // splash 페이지 넘어감
      return;
    }

    Map<String, dynamic> body = await UserRepository().login(idToken);
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
      Navigator.pushNamed(mContext, "/login");
      return;
    }

    // 3. 파싱
    User user = User.fromMap(body["data"]);

    // 4. 세션모델 갱신
    state = SessionModel(user: user, isLogin: true);

    // 5. dio의 header에 토큰 세팅 (Bearer 포함)
    dio.options.headers["Authorization"] = "Bearer " + user.idToken!;

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

    // 6. 게시글 목록 페이지 이동
    Navigator.pushNamed(mContext, "/running");
  }

  Future<void> login(BuildContext mContext, String idToken) async {
    // 1. 유효성 검사 (카카오로 넘기는 거라 필요 없음)
    /*Logger().d("username : ${username}, password : ${password}");
    bool isValid = ref.read(loginProvider.notifier).validate();
    if (!isValid) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("유효성 검사 실패입니다")),
      );
      return;
    }*/

    // 2. 통신
    Map<String, dynamic> body = await UserRepository().login(idToken);
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
      return;
    }

    // 3. 파싱
    User user = User.fromMap(body["data"]);

    // 4. 토큰을 디바이스 저장 ( 앱 다시 실행 시 자동 로그인 )
    await secureStorage.write(key: "idToken", value: user.idToken);

    // 5. 세션모델 갱신
    state = SessionModel(user: user, isLogin: true);

    // 6. dio의 header에 토큰 세팅 (Bearer 포함)
    dio.options.headers["Authorization"] = "Bearer " + user.idToken!;

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

    // 7. 게시글 목록 페이지 이동
    Navigator.pushNamed(mContext, "/join");
  }

  Future<void> logout(BuildContext mContext) async {
    // 1. 토큰 디바이스 제거
    await secureStorage.delete(key: "idToken");

    // 2. 세션모델 초기화
    state = SessionModel();

    // 3. dio 세팅 제거
    dio.options.headers["Authorization"] = "";

    // 4. login 페이지 이동
    Navigator.pushNamedAndRemoveUntil(mContext, "/login", (route) => false);
  }

  Future<void> editUserInfo(String gender, double height, double weight) async {
    var body = await UserRepository().editUserInfoAndJoin(state.user!.id, gender, height, weight);
    var userInfo = body['data'];
    state = SessionModel(
      user: state.user!.copyWith(
        gender: userInfo['gender'],
        height: userInfo['height'],
        weight: userInfo['weight'],
      ),
      isLogin: state.isLogin,
    );
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class SessionModel {
  User? user;
  bool? isLogin;

  SessionModel({this.user, this.isLogin = false});

  @override
  String toString() {
    return 'SessionModel{user: $user, isLogin: $isLogin}';
  }
}

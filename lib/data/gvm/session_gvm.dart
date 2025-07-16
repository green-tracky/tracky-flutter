import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/my_http.dart';
import 'package:tracky_flutter/data/model/User.dart';
import 'package:tracky_flutter/data/repository/UserRepository.dart';

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

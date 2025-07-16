import '../../_core/utils/my_http.dart';

class UserRepository {
  Future<Map<String, dynamic>> login(String idToken) async {
    var reqBody = {"idToken": idToken};
    var response = await dio.post('/api/oauth/kakao/login', data: reqBody);
    if (response.statusCode == 200 && response.data != null) {
      print("로그인 성공");
    }
    return response.data;
  }

  Future<Map<String, dynamic>> editUserInfoAndJoin(int userId, String gender, double height, double weight) async {
    var reqBody = {"gender": gender, "height": height, "weight": weight};
    var response = await dio.put('/s/api/users/$userId', data: reqBody);
    if (response.statusCode == 200 && response.data != null) {
      print("회원가입 성공");
    }
    return response.data;
  }
}

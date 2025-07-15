import 'package:dio/dio.dart';
import 'package:tracky_flutter/data/model/Friend.dart';

class FriendRepository {
  final Dio dio;

  FriendRepository(this.dio);

  // 1. 친구 태그로 검색
  Future<List<UserProfile>> searchFriendByTag(String tag) async {
    print('[친구 검색 시작] tag: $tag'); // ① 검색 시작 직후 태그 출력

    try {
      final response = await dio.get(
        '/friends/search',
        queryParameters: {'user-tag': tag},
      );

      print('[친구 검색 응답] statusCode: ${response.statusCode}');
      print('[친구 검색 응답 데이터] ${response.data}'); // ② 서버에서 받은 전체 응답 데이터 출력

      final resData = response.data['data'];

      if (resData is List) {
        print('[친구 검색 결과 수] ${resData.length}명'); // ③ 실제 친구 리스트 개수 출력
        return resData.map((e) => UserProfile.fromJson(e)).toList();
      } else {
        print("[친구 검색] data가 List가 아님: $resData (${resData.runtimeType})");
        return [];
      }
    } catch (e, st) {
      print('[친구 검색 에러] $e\n$st'); // ④ 에러 발생 시 출력
      rethrow;
    }
  }

  // 2. 친구 요청 (친구ID 기준)
  Future<void> inviteFriend(int userId) async {
    print('[Repo] 친구 요청 시작 → 대상 userId: $userId');

    try {
      final response = await dio.post(
        '/s/api/friends/invite/users/$userId',
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );
      print('[Repo] 친구 요청 성공: ${response.data}');
    } catch (e) {
      print('[Repo] 친구 요청 실패: $e');
      rethrow;
    }
  }

  // 3. 친구 상세 조회(프로필)
  Future<UserProfile> fetchFriendProfile(int userId) async {
    final response = await dio.get('/users/$userId');
    return UserProfile.fromJson(response.data['data']);
  }

  // 4. 친구 리스트
  Future<List<Friend>> fetchFriendList() async {
    final response = await dio.get('/friends/list');
    print('친구 목록 서버 응답: ${response.data}');
    final resData = response.data['data'];
    if (resData is List) {
      return resData.map((e) => Friend.fromJson(e)).toList();
    } else {
      print("data가 List가 아님: $resData (${resData.runtimeType})");
      return [];
    }
  }
}

import 'package:dio/dio.dart';
import 'package:tracky_flutter/data/model/Friend.dart';

class FriendRepository {
  final Dio dio;
  FriendRepository(this.dio);

  /// 1. 친구 태그로 검색
  Future<List<UserProfile>> searchFriendByTag(String tag) async {
    print('[Repo] 친구 검색 요청: $tag');
    final response = await dio.get(
      '/s/api/friends/search',
      queryParameters: {'user-tag': tag},
    );
    print('[Repo] 응답: ${response.data}');

    final resData = response.data['data'];
    if (resData is List) {
      print('[Repo] 친구 ${resData.length}명 파싱 중');
      return resData.map((e) => UserProfile.fromJson(e)).toList();
    } else {
      print('[Repo] data가 List가 아님: $resData (${resData.runtimeType})');
      return [];
    }
  }

  /// 2. 친구 요청
  Future<void> inviteFriend(int userId) async {
    print('[Repo] 친구 요청 시작 → 대상 userId: $userId');
    try {
      final response = await dio.post('/s/api/friends/invite/users/$userId');
      print('[Repo] 친구 요청 성공: ${response.data}');
    } catch (e) {
      print('[Repo] 친구 요청 실패: $e');
      rethrow;
    }
  }

  /// 3. 친구 프로필 조회
  Future<UserProfile> fetchFriendProfile(int userId) async {
    final response = await dio.get('/s/api/users/$userId');
    return UserProfile.fromJson(response.data['data']);
  }

  /// 4. 친구 리스트 조회
  Future<List<Friend>> fetchFriendList() async {
    try {
      final response = await dio.get('/s/api/friends/list');
      print('친구 목록 서버 응답: ${response.data}');

      final resData = response.data['data'];
      if (resData is List) {
        print('친구 리스트 파싱 성공! ${resData.length}명');
        return resData.map((e) => Friend.fromJson(e)).toList();
      } else {
        print('data가 List가 아님: $resData (${resData.runtimeType})');
        return [];
      }
    } catch (e) {
      print('친구 리스트 API 에러: $e');
      rethrow;
    }
  }

  /// 5. 친구 삭제
  Future<void> deleteFriend(int toUserId) async {
    try {
      print('[Repo] 친구 삭제 요청 → toUserId: $toUserId');
      final response = await dio.delete('/s/api/friends/$toUserId');
      print('[Repo] 친구 삭제 성공: ${response.data}');
    } catch (e) {
      print('[Repo] 친구 삭제 실패: $e');
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:tracky_flutter/data/model/Friend.dart';

import '../../_core/utils/dio.dart';

import 'package:dio/dio.dart';

import '../../_core/utils/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ChallengeRepository {
  Dio get _dio => dio; // Dio getter

  Dio get _dio => dio;

  /// 챌린지 상세 조회
  Future<Map<String, dynamic>> getChallengeDetailById(int id) async {
    try {
      print('[getChallengeDetailById] 요청 시작 id=$id');
      final res = await _dio.get('/community/challenges/$id');
      print('[getChallengeDetailById] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getChallengeDetailById] 성공');
        return map['data'];
      } else {
        print('[getChallengeDetailById] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getChallengeDetailById] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  /// 챌린지 목록 조회
  Future<Map<String, dynamic>> getChallengeList() async {
    try {
      print('[getChallengeList] 요청 시작');
      final res = await _dio.get('/community/challenges');
      print('[getChallengeList] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getChallengeList] 성공적으로 데이터 반환');
        return map['data'];
      } else {
        print('[getChallengeList] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getChallengeList] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  /// 챌린지 리더보드 조회
  Future<Map<String, dynamic>> getChallengeLeaderBoardById(int id) async {
    try {
      print('[getChallengeLeaderBoardById] 요청 시작 id=$id');
      final res = await _dio.get('/community/challenges/$id/leaderboard');
      print('[getChallengeLeaderBoardById] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getChallengeLeaderBoardById] 성공');
        return map['data'];
      } else {
        print('[getChallengeLeaderBoardById] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getChallengeLeaderBoardById] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  /// 챌린지 이름 수정 (사설 챌린지만 가능)
  Future<Map<String, dynamic>> updateChallenge(int challengeId, String name) async {
    try {
      print('[updateChallenge] 요청 시작 id=$challengeId, name=$name');
      final res = await _dio.put(
        '/community/challenges/$challengeId',
        data: {'name': name},
      );
      print('[updateChallenge] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[updateChallenge] 성공');
        return map['data'];
      } else {
        print('[updateChallenge] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[updateChallenge] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<void> inviteChallenge(int challengeId, int userId) async {
    print('[Repo] 챌린지 초대 요청 시작 → 대상 userId: $userId');
    var userIdArray = [userId];
    try {
      final response = await dio.post(
        '/community/challenges/$challengeId/invite',
        data: {"friendIds": userIdArray},
      );
      print('[Repo] 챌린지 초대 요청 성공: ${response.data}');
    } catch (e) {
      print('[Repo] 챌린지 초대 요청 실패: $e');
      rethrow;
    }
  }

  Future<List<Friend>> fetchChallengeFriendList(int challengeId) async {
    try {
      final response = await dio.get(
        '/community/challenges/$challengeId/invite/available-friends',
      );
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

  Future<void> createChallenge({
    required int imgIndex,
    required String name,
    required int targetDistance,
    required String startDate,
    required String endDate,
  }) async {
    var reqBody = {
      "imgIndex": imgIndex,
      "name": name,
      "targetDistance": targetDistance,
      "startDate": startDate,
      "endDate": endDate
    };

    try {
      final response = await dio.post('/community/challenges', data: reqBody);
    } catch (e) {
      print('통신 실패 : $e');
      rethrow;
    }
  }
}

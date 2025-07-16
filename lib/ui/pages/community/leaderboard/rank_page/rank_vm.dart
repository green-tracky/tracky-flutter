import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/my_http.dart';

class RankingUser {
  final int userId;
  final String username;
  final String profileUrl;
  final int totalDistanceMeters;
  final int rank;

  RankingUser({
    required this.userId,
    required this.username,
    required this.profileUrl,
    required this.totalDistanceMeters,
    required this.rank,
  });

  factory RankingUser.fromJson(Map<String, dynamic> json) {
    return RankingUser(
      userId: json['userId'],
      username: json['username'],
      profileUrl: json['profileUrl'],
      totalDistanceMeters: int.tryParse(json['totalDistanceMeters'].toString()) ?? 0,
      rank: int.tryParse(json['rank'].toString()) ?? 0,
    );
  }
}

class RankingState {
  final Map<String, dynamic>? myRankingRaw;
  final List<RankingUser> rankingList;

  RankingState({required this.myRankingRaw, required this.rankingList});
}

class RankingNotifier extends StateNotifier<RankingState> {
  final Dio dio;

  RankingNotifier({required this.dio}) : super(RankingState(myRankingRaw: null, rankingList: []));

  String _endpointFromFilter(String filter) {
    switch (filter) {
      case '이번 주 친구 기록(KM)':
        return '/s/api/community/leaderboards/week';
      case '지난 주 친구 기록(KM)':
        return '/s/api/community/leaderboards/week?before=1';
      case '이번 달 친구 기록(KM)':
        return '/s/api/community/leaderboards/mouth';
      case '지난 달 친구 기록(KM)':
        return '/s/api/community/leaderboards/mouth?before=1';
      case '올해 친구 기록(KM)':
        return '/s/api/community/leaderboards/year';
      default:
        return '/s/api/community/leaderboards/week';
    }
  }

  Future<void> fetchRankingData(String filter) async {
    final url = _endpointFromFilter(filter);
    print('[랭킹 요청] filter="$filter" → $url');

    try {
      final response = await dio.get(url);
      print('[랭킹 응답 전체] ${response.data}');

      final resData = response.data;

      if (resData['data'] is! Map<String, dynamic>) {
        print('[랭킹 경고] "data"가 Map이 아님 → ${resData['data']}');
        throw Exception('"data" field is not a Map');
      }

      final data = resData['data'] as Map<String, dynamic>;
      final my = data['myRanking'] as Map<String, dynamic>?;
      final list = data['rankingList'] as List;

      print('[랭킹 응답] 내 랭킹: $my');
      print('[랭킹 응답] 유저 ${list.length}명');

      final rankingList = list.map((e) => RankingUser.fromJson(e)).toList();

      state = RankingState(myRankingRaw: my, rankingList: rankingList);
    } catch (e, st) {
      print('[랭킹 오류] $e');
      state = RankingState(myRankingRaw: null, rankingList: []);
    }
  }
}

final rankingProvider = StateNotifierProvider<RankingNotifier, RankingState>((ref) {
  final dioInstance = ref.read(dioProvider);
  return RankingNotifier(dio: dioInstance);
});

final rankFilterProvider = StateProvider<String>((ref) {
  return '이번 달 친구 기록(KM)';
});

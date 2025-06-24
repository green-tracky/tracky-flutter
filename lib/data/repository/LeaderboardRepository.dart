import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Leaderboard.dart';

class LeaderboardRepository {
  Future<List<RankUser>> getRankListByFilter(String filter) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (filter == '이번 달 친구 기록(KM)') {
      return [
        RankUser(rank: 1, name: 'ssar', distance: 12.3),
        RankUser(rank: 2, name: 'cos', distance: 10.5),
        RankUser(rank: 3, name: 'love'),
        RankUser(rank: 4, name: 'haha'),
      ];
    } else {
      return [];
    }
  }
}

// Provider 같이 정의
final leaderboardRepositoryProvider = Provider<LeaderboardRepository>((ref) {
  return LeaderboardRepository();
});

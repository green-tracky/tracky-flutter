import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      totalDistanceMeters: json['totalDistanceMeters'],
      rank: json['rank'],
    );
  }
}

class RankingState {
  final RankingUser? myRanking;
  final List<RankingUser> rankingList;

  RankingState({required this.myRanking, required this.rankingList});
}

class RankingNotifier extends StateNotifier<RankingState> {
  RankingNotifier() : super(RankingState(myRanking: null, rankingList: []));

  // 필터 파라미터를 받도록 수정!
  void fetchRankingData(String filter) {
    if (filter == '이번 달 친구 기록(KM)') {
      state = RankingState(
        myRanking: RankingUser(
          userId: 1,
          username: "me",
          profileUrl: "http://example.com/profiles/ssar.jpg",
          totalDistanceMeters: 3700,
          rank: 1,
        ),
        rankingList: [
          RankingUser(
            userId: 2,
            username: "ssar",
            profileUrl: "http://example.com/profiles/ssar.jpg",
            totalDistanceMeters: 3700,
            rank: 1,
          ),
          RankingUser(
            userId: 3,
            username: "love",
            profileUrl: "http://example.com/profiles/love.jpg",
            totalDistanceMeters: 0,
            rank: 2,
          ),
          RankingUser(
            userId: 4,
            username: "haha",
            profileUrl: "http://example.com/profiles/haha.jpg",
            totalDistanceMeters: 0,
            rank: 2,
          ),
          RankingUser(
            userId: 5,
            username: "green",
            profileUrl: "http://example.com/profiles/green.jpg",
            totalDistanceMeters: 0,
            rank: 2,
          ),
          RankingUser(
            userId: 6,
            username: "leo",
            profileUrl: "http://example.com/profiles/leo.jpg",
            totalDistanceMeters: 0,
            rank: 2,
          ),
        ],
      );
    } else {
      // 나머지 필터는 모두 null/빈 배열로
      state = RankingState(
        myRanking: null,
        rankingList: [],
      );
    }
  }
}

final rankingProvider = StateNotifierProvider<RankingNotifier, RankingState>((ref) {
  return RankingNotifier();
});

final rankFilterProvider = StateProvider<String>((ref) {
  return '이번 달 친구 기록(KM)';
});

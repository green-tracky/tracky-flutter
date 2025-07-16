import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';

// Provider 정의
final challengeDetailProvider = AutoDisposeAsyncNotifierProviderFamily<ChallengeDetailVM, ChallengeDetailModel?, int>(
  ChallengeDetailVM.new,
);

// ViewModel 정의
class ChallengeDetailVM extends AutoDisposeFamilyAsyncNotifier<ChallengeDetailModel?, int> {
  @override
  Future<ChallengeDetailModel?> build(int id) async {
    try {
      final challengeResponse = await ChallengeRepository().getChallengeDetailById(id);
      final challengeLeaderBoardResponse = await ChallengeRepository().getChallengeLeaderBoardById(id);

      // 둘 다 data만 반환하는 구조로 통일했다면 아래처럼!
      final challengeData = challengeResponse; // 이미 Map<String, dynamic>
      final leaderboardList = (challengeLeaderBoardResponse['rankingList'] is List)
          ? (challengeLeaderBoardResponse['rankingList'] as List)
                .where((e) => e is Map)
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList()
          : <Map<String, dynamic>>[];

      final mergedData = <String, dynamic>{
        ...challengeData,
        'leaderboard': leaderboardList,
      };

      return ChallengeDetailModel.fromMap(mergedData);
    } catch (e, st) {
      print('[ChallengeDetailVM] 에러: $e\n$st');
      return null;
    }
  }
}

// RankingEntry null/type-safe
class RankingEntry {
  final String profileUrl;
  final String username;
  final int totalDistanceMeters;
  final int rank;
  final int userId;

  RankingEntry({
    required this.profileUrl,
    required this.username,
    required this.totalDistanceMeters,
    required this.rank,
    required this.userId,
  });

  factory RankingEntry.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return RankingEntry(
        profileUrl: '',
        username: '',
        totalDistanceMeters: 0,
        rank: 0,
        userId: 0,
      );
    }
    return RankingEntry(
      profileUrl: map['profileUrl'] ?? '',
      username: map['username'] ?? '',
      totalDistanceMeters: map['totalDistanceMeters'] ?? 0,
      rank: map['rank'] ?? 0,
      userId: map['userId'] ?? 0,
    );
  }
}

// ChallengeDetailModel null/type-safe
class ChallengeDetailModel {
  final int id;
  final String name;
  final String? sub;
  final String? imageUrl;
  final double myDistance;
  final double targetDistance;
  final int remainingTime;
  final bool isInProgress;
  final int participantCount;
  final String startDate;
  final String endDate;
  final bool isCreatedByMe;
  final int rank;
  final List<RankingEntry> leaderboard;

  ChallengeDetailModel({
    required this.id,
    required this.name,
    this.sub,
    this.imageUrl,
    required this.myDistance,
    required this.targetDistance,
    required this.remainingTime,
    required this.isInProgress,
    required this.participantCount,
    required this.startDate,
    required this.endDate,
    required this.isCreatedByMe,
    required this.rank,
    required this.leaderboard,
  });

  factory ChallengeDetailModel.fromMap(Map<String, dynamic> data) {
    // leaderboard null/type-safe
    final leaderboardData = (data['leaderboard'] is List)
        ? (data['leaderboard'] as List)
              .where((e) => e is Map)
              .map((e) => RankingEntry.fromMap(e as Map<String, dynamic>))
              .toList()
        : <RankingEntry>[];

    return ChallengeDetailModel(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      sub: data['sub'],
      imageUrl: data['imageUrl'],
      myDistance: ((data['myDistance'] ?? 0) is num) ? (data['myDistance'] as num).toDouble() / 1000 : 0.0,
      targetDistance: ((data['targetDistance'] ?? 0) is num) ? (data['targetDistance'] as num).toDouble() / 1000 : 0.0,
      remainingTime: data['remainingTime'] ?? 0,
      isInProgress: data['isInProgress'] ?? false,
      participantCount: data['participantCount'] ?? 0,
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      isCreatedByMe: data['isCreatedByMe'] ?? false,
      rank: data['rank'] ?? 0,
      leaderboard: leaderboardData,
    );
  }
}

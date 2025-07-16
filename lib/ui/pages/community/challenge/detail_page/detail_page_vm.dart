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
      final challengeData = Map<String, dynamic>.from(challengeResponse['data'] ?? {});

      List<Map<String, dynamic>> leaderboardList = [];

      final isJoined = challengeData['isJoined'] == true;
      if (isJoined) {
        final challengeLeaderBoardResponse = await ChallengeRepository().getChallengeLeaderBoardById(id);
        final leaderboardRaw = challengeLeaderBoardResponse['data'];

        if (leaderboardRaw != null && leaderboardRaw is Map<String, dynamic> && leaderboardRaw['rankingList'] is List) {
          leaderboardList = (leaderboardRaw['rankingList'] as List)
              .where((e) => e is Map)
              .map((e) => Map<String, dynamic>.from(e as Map))
              .toList();
        }
      }

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

  Future<void> joinChallenge(int challengeId) async {
    var body = await ChallengeRepository().joinChallenge(challengeId);
    if (body['status'] == 200) print("챌린지 참가 성공");
  }
}

// RankingEntry
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

// ChallengeDetailModel
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
  final bool isJoined;

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
    required this.isJoined,
  });

  factory ChallengeDetailModel.fromMap(Map<String, dynamic> data) {
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
      myDistance: (data['myDistance'] is num) ? (data['myDistance'] as num).toDouble() / 1000 : 0.0,
      targetDistance: (data['targetDistance'] is num) ? (data['targetDistance'] as num).toDouble() / 1000 : 0.0,
      remainingTime: data['remainingTime'] ?? 0,
      isInProgress: data['isInProgress'] ?? false,
      participantCount: data['participantCount'] ?? 0,
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      isCreatedByMe: data['isCreatedByMe'] ?? false,
      rank: data['rank'] ?? 0,
      leaderboard: leaderboardData,
      isJoined: data['isJoined'] ?? false,
    );
  }
}

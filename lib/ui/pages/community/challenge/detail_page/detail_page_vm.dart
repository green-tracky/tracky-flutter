import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';
import 'package:tracky_flutter/main.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';

// Provider 정의
final challengeDetailProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      ChallengeDetailVM,
      ChallengeDetailModel?,
      int
    >(ChallengeDetailVM.new);

// ViewModel 정의
class ChallengeDetailVM
    extends AutoDisposeFamilyAsyncNotifier<ChallengeDetailModel?, int> {
  @override
  Future<ChallengeDetailModel?> build(int id) async {
    final challengeResponse = await ChallengeRepository()
        .getChallengeDetailById(id);
    final challengeLeaderBoardResponse = await ChallengeRepository()
        .getChallengeLeaderBoardbyId(id);

    final challengeData = Map<String, dynamic>.from(
      challengeResponse['data'],
    );
    final leaderboardData = List<Map<String, dynamic>>.from(
      challengeLeaderBoardResponse['data']['rankingList'],
    );
    final myRanking = Map<String, dynamic>.from(
      challengeLeaderBoardResponse['data']['myRanking'],
    );

    final mergedData = <String, dynamic>{
      ...challengeData,
      'myDistance': (myRanking['totalDistanceMeters'] ?? 0).toDouble() / 1000,
      'rank': myRanking['rank'] ?? 0,
      'leaderboard': leaderboardData,
    };

    return ChallengeDetailModel.fromMap(mergedData);
  }
}

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

  factory RankingEntry.fromMap(Map<String, dynamic> map) {
    return RankingEntry(
      profileUrl: map['profileUrl'],
      username: map['username'],
      totalDistanceMeters: map['totalDistanceMeters'],
      rank: map['rank'],
      userId: map['userId'],
    );
  }
}

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
    final leaderboardData = data['leaderboard'] ?? [];

    return ChallengeDetailModel(
      id: data['id'],
      name: data['name'] ?? '',
      sub: data['sub'],
      imageUrl: data['imageUrl'],
      myDistance: (data['myDistance'] ?? 0).toDouble() / 1000,
      targetDistance: (data['targetDistance'] ?? 0).toDouble() / 1000,
      remainingTime: data['remainingTime'] ?? 0,
      isInProgress: data['isInProgress'] ?? false,
      participantCount: data['participantCount'] ?? 0,
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      isCreatedByMe: data['isCreatedByMe'] ?? false,
      rank: data['rank'] ?? 0,
      leaderboard: List<RankingEntry>.from(
        leaderboardData.map((e) => RankingEntry.fromMap(e)),
      ),
    );
  }
}

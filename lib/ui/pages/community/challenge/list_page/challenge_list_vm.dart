import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';
import 'package:tracky_flutter/main.dart';

final challengeListProvider =
    AsyncNotifierProvider<ChallengeListVM, ChallengeListModel>(ChallengeListVM.new);

class ChallengeListVM extends AsyncNotifier<ChallengeListModel> {
  @override
  Future<ChallengeListModel> build() async {
    final response = await ChallengeRepository().getChallengeList();
    return ChallengeListModel.fromMap(response['data']);
  }
}

class ChallengeListModel {
  final List<InviteChallenge> inviteChallenges;
  final RecommendedChallenge? recommendedChallenge;
  final List<ChallengeSummary> myChallenges;
  final List<ChallengeSummary> joinableChallenges;
  final List<ChallengeSummary> pastChallenges;

  ChallengeListModel({
    required this.inviteChallenges,
    required this.recommendedChallenge,
    required this.myChallenges,
    required this.joinableChallenges,
    required this.pastChallenges,
  });

  factory ChallengeListModel.fromMap(Map<String, dynamic> map) {
    return ChallengeListModel(
      inviteChallenges: List<Map<String, dynamic>>.from(
        map['inviteChallenges'] ?? [],
      ).map((e) => InviteChallenge.fromMap(e)).toList(),
      recommendedChallenge: map['recommendedChallenge'] != null
          ? RecommendedChallenge.fromMap(map['recommendedChallenge'])
          : null,
      myChallenges: List<Map<String, dynamic>>.from(
        map['myChallenges'] ?? [],
      ).map((e) => ChallengeSummary.fromMap(e)).toList(),
      joinableChallenges: List<Map<String, dynamic>>.from(
        map['joinableChallenges'] ?? [],
      ).map((e) => ChallengeSummary.fromMap(e)).toList(),
      pastChallenges: List<Map<String, dynamic>>.from(
        map['pastChallenges'] ?? [],
      ).map((e) => ChallengeSummary.fromMap(e)).toList(),
    );
  }
}

class InviteChallenge {
  final int challengeInviteId;
  final String fromUsername;
  final ChallengeSummary challengeInfo;

  InviteChallenge({
    required this.challengeInviteId,
    required this.fromUsername,
    required this.challengeInfo,
  });

  factory InviteChallenge.fromMap(Map<String, dynamic> map) {
    return InviteChallenge(
      challengeInviteId: map['challengeInviteId'],
      fromUsername: map['fromUsername'],
      challengeInfo: ChallengeSummary.fromMap(map['challengeInfo']),
    );
  }
}

class RecommendedChallenge {
  final int id;
  final String name;
  final String imageUrl;
  final int participantCount;
  final String type;

  RecommendedChallenge({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.participantCount,
    required this.type,
  });

  factory RecommendedChallenge.fromMap(Map<String, dynamic> map) {
    return RecommendedChallenge(
      id: map['id'],
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      participantCount: map['participantCount'] ?? 0,
      type: map['type'] ?? '',
    );
  }
}

class ChallengeSummary {
  final int id;
  final String name;
  final String? sub;
  final String? imageUrl;
  final int remainingTime;
  final int? myDistance;
  final int? targetDistance;
  final bool isInProgress;
  final String? endDate;
  final String type;

  ChallengeSummary({
    required this.id,
    required this.name,
    this.sub,
    this.imageUrl,
    required this.remainingTime,
    this.myDistance,
    this.targetDistance,
    required this.isInProgress,
    this.endDate,
    required this.type,
  });

  factory ChallengeSummary.fromMap(Map<String, dynamic> map) {
    return ChallengeSummary(
      id: map['id'],
      name: map['name'] ?? '',
      sub: map['sub'],
      imageUrl: map['imageUrl'],
      remainingTime: map['remainingTime'] ?? 0,
      myDistance: map['myDistance'],
      targetDistance: map['targetDistance'], // key 그대로 사용
      isInProgress: map['isInProgress'] ?? false,
      endDate: map['endDate'],
      type: map['type'] ?? '',
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';

final challengeListProvider = AsyncNotifierProvider<ChallengeListVM, ChallengeListModel>(ChallengeListVM.new);

class ChallengeListVM extends AsyncNotifier<ChallengeListModel> {
  @override
  Future<ChallengeListModel> build() async {
    final response = await ChallengeRepository().getChallengeList();
    return ChallengeListModel.fromMap(response);
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
    List<InviteChallenge> safeInviteChallenges() {
      final list = map['inviteChallenges'];
      if (list is List) {
        return list.where((e) => e is Map).map((e) => InviteChallenge.fromMap(e as Map<String, dynamic>)).toList();
      }
      return [];
    }

    List<ChallengeSummary> safeChallengeList(String key) {
      final list = map[key];
      if (list is List) {
        return list.where((e) => e is Map).map((e) => ChallengeSummary.fromMap(e as Map<String, dynamic>)).toList();
      }
      return [];
    }

    return ChallengeListModel(
      inviteChallenges: safeInviteChallenges(),
      recommendedChallenge: (map['recommendedChallenge'] is Map)
          ? RecommendedChallenge.fromMap(map['recommendedChallenge'] as Map<String, dynamic>)
          : null,
      myChallenges: safeChallengeList('myChallenges'),
      joinableChallenges: safeChallengeList('joinableChallenges'),
      pastChallenges: safeChallengeList('pastChallenges'),
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

  factory InviteChallenge.fromMap(Map<String, dynamic>? map) {
    if (map == null) throw Exception('InviteChallenge map is null');
    return InviteChallenge(
      challengeInviteId: map['challengeInviteId'] ?? 0,
      fromUsername: map['fromUsername'] ?? '',
      challengeInfo: (map['challengeInfo'] is Map)
          ? ChallengeSummary.fromMap(map['challengeInfo'] as Map<String, dynamic>)
          : ChallengeSummary.empty(),
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

  factory RecommendedChallenge.fromMap(Map<String, dynamic>? map) {
    if (map == null) throw Exception('RecommendedChallenge map is null');
    return RecommendedChallenge(
      id: map['id'] ?? 0,
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

  factory ChallengeSummary.fromMap(Map<String, dynamic>? map) {
    if (map == null) return ChallengeSummary.empty();
    return ChallengeSummary(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      sub: map['sub'],
      imageUrl: map['imageUrl'],
      remainingTime: map['remainingTime'] ?? 0,
      myDistance: map['myDistance'],
      targetDistance: map['targetDistance'],
      isInProgress: map['isInProgress'] ?? false,
      endDate: map['endDate'],
      type: map['type'] ?? '',
    );
  }

  factory ChallengeSummary.empty() {
    return ChallengeSummary(
      id: 0,
      name: '',
      sub: null,
      imageUrl: null,
      remainingTime: 0,
      myDistance: null,
      targetDistance: null,
      isInProgress: false,
      endDate: null,
      type: '',
    );
  }
}

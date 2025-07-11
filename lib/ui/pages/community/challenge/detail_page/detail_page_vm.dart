import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/main.dart';

final challengeDetailProvider =
    AutoDisposeNotifierProvider<ChallengeDetailVM, ChallengeDetailModel?>(
  () => ChallengeDetailVM(),
);

class ChallengeDetailVM extends AutoDisposeNotifier<ChallengeDetailModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  ChallengeDetailModel? build() {
    init(); // 비동기 초기화
    return null;
  }

  Future<void> init({int id = 5}) async {
    // 더미 데이터를 임시로 할당
    final dummyData = {
      "id": 5,
      "name": "6월 100k 챌린지",
      "sub": "이번 달 100km를 달성해보세요!",
      "imageUrl": "https://example.com/rewards/100km_badge.png",
      "myDistance": 17.2,
      "targetDistance": 100.0,
      "remainingTime": 2273983,
      "isInProgress": true,
      "participantCount": 42049,
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "isCreatedByMe": false,
    };

    state = ChallengeDetailModel.fromMap(dummyData);
  }
}


class ChallengeDetailModel {
  final int id;
  final String name;
  final String? sub;
  final String? imageUrl;
  final double? myDistance;
  final double? targetDistance;
  final int remainingTime; // 초 단위
  final bool isInProgress;
  final int participantCount;
  final String startDate;
  final String endDate;
  final bool isCreatedByMe;

  ChallengeDetailModel({
    required this.id,
    required this.name,
    this.sub,
    this.imageUrl,
    this.myDistance,
    this.targetDistance,
    required this.remainingTime,
    required this.isInProgress,
    required this.participantCount,
    required this.startDate,
    required this.endDate,
    required this.isCreatedByMe,
  });

  factory ChallengeDetailModel.fromMap(Map<String, dynamic> data) {
    return ChallengeDetailModel(
      id: data['id'],
      name: data['name'] ?? '',
      sub: data['sub'],
      imageUrl: data['imageUrl'],
      myDistance: (data['myDistance'] ?? 0).toDouble(),
      targetDistance: (data['targetDistance'] ?? 0).toDouble(),
      remainingTime: data['remainingTime'] ?? 0,
      isInProgress: data['isInProgress'] ?? false,
      participantCount: data['participantCount'] ?? 0,
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      isCreatedByMe: data['isCreatedByMe'] ?? false,
    );
  }

  ChallengeDetailModel copyWith({
    double? myDistance,
    bool? isInProgress,
  }) {
    return ChallengeDetailModel(
      id: id,
      name: name,
      sub: sub,
      imageUrl: imageUrl,
      myDistance: myDistance ?? this.myDistance,
      targetDistance: targetDistance,
      remainingTime: remainingTime,
      isInProgress: isInProgress ?? this.isInProgress,
      participantCount: participantCount,
      startDate: startDate,
      endDate: endDate,
      isCreatedByMe: isCreatedByMe,
    );
  }
}

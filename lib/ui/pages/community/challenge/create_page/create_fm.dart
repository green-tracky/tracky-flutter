import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/challenge_list_vm.dart';

final challengeCreateProvider =
    NotifierProvider<ChallengeCreateFM, ChallengeCreateModel>(
      ChallengeCreateFM.new,
    );

class ChallengeCreateFM extends Notifier<ChallengeCreateModel> {
  @override
  ChallengeCreateModel build() {
    return ChallengeCreateModel();
  }

  void setImageIndex(int index) {
    state = state.copyWith(imageIndex: index);
  }

  void setChallengeName(String name) {
    state = state.copyWith(challengeName: name);
  }

  void setDistance(double distance) {
    state = state.copyWith(distance: distance);
  }

  void setStartDate(String date) {
    state = state.copyWith(startDate: date);
  }

  void setEndDate(String date) {
    state = state.copyWith(endDate: date);
  }

  Future<void> submitChallenge(WidgetRef ref, BuildContext context) async {
    // 여기에 통신 로직 추가
    try {
      // 예: API 요청
      /* await ChallengeRepository().createChallenge(
      imageIndex: ref.read(challengeCreateProvider).imageIndex,
      title: ref.read(challengeCreateProvider).title,
      distance: ref.read(challengeCreateProvider).distance,
      date: ref.read(challengeCreateProvider).date,
    ); */

      // 챌린지 목록 Provider 강제 초기화
      ref.invalidate(challengeListProvider);

      // 이전 화면으로 이동
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("챌린지 생성 실패: $e")),
      );
    }

    print("챌린지 생성 요청");
    print("이름: ${state.challengeName}");
    print("거리: ${state.distance}");
    print("시작일: ${state.startDate}");
    print("종료일: ${state.endDate}");
    print("이미지 인덱스: ${state.imageIndex}");

    // 예: await ChallengeRepository().createChallenge(...)
  }

  void reset() {
    state = ChallengeCreateModel();
  }
}

class ChallengeCreateModel {
  final int? imageIndex;
  final String? challengeName;
  final double? distance;
  final String? startDate;
  final String? endDate;

  ChallengeCreateModel({
    this.imageIndex,
    this.challengeName,
    this.distance,
    this.startDate,
    this.endDate,
  });

  ChallengeCreateModel copyWith({
    int? imageIndex,
    String? challengeName,
    double? distance,
    String? startDate,
    String? endDate,
  }) {
    return ChallengeCreateModel(
      imageIndex: imageIndex ?? this.imageIndex,
      challengeName: challengeName ?? this.challengeName,
      distance: distance ?? this.distance,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  bool get isValid =>
      imageIndex != null &&
      (challengeName?.isNotEmpty ?? false) &&
      distance != null &&
      startDate != null &&
      endDate != null;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart'; // Needed for BuildContext and ScaffoldMessenger
import 'package:intl/intl.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/challenge_list_vm.dart'; // Assuming this provides challengeListProvider

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
    print("이미지 인덱스 : ${state.imageIndex}");
  }

  void setChallengeName(String name) {
    state = state.copyWith(challengeName: name);
    print("제목 : ${state.challengeName}");
  }

  void setDistance(double distance) {
    state = state.copyWith(distance: distance);
    print("거리 : ${state.distance} km");
  }

  // Change type from String to DateTime
  void setStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
    print("시작 날짜 : ${state.startDate}");
  }

  // Change type from String to DateTime
  void setEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
    print("종료 날짜 : ${state.endDate}");
  }

  Future<void> submitChallenge(WidgetRef ref, BuildContext context) async {
    // Check form validity before submission
    if (!state.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all challenge details.")),
      );
      return;
    }

    try {
      // Assuming ChallengeRepository needs to be provided,
      // or you have a default constructor that doesn't require ref/dio.
      // If ChallengeRepository requires ref, you would need to adjust how it's accessed.

      String formattedStartDate = state.startDate!.toIso8601String().split('.')[0].replaceFirst('T', ' '); // <--- 여기 수정
      String formattedEndDate = state.endDate!.toIso8601String().split('.')[0].replaceFirst('T', ' ');     // <--- 여기 수정
      await ChallengeRepository().createChallenge(
        imgIndex: state.imageIndex!, // Use state directly
        name: state.challengeName!,
        targetDistance: (state.distance! * 1000).toInt(),
        startDate: formattedStartDate,
        endDate: formattedEndDate,
      );

      // Invalidate the challenge list provider to refresh the list
      ref.invalidate(challengeListProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Challenge created successfully!")),
      );

      // Pop the current screen after successful creation
      Navigator.pop(context);
    } catch (e) {
      print("Challenge creation failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create challenge: $e")),
      );
    }

    // Debug prints (optional, can be removed in production)
    print("Challenge creation request");
    print("Name: ${state.challengeName}");
    print("Distance: ${state.distance}");
    print("Start Date: ${state.startDate}");
    print("End Date: ${state.endDate}");
    print("Image Index: ${state.imageIndex}");
    reset();
  }

  void reset() {
    state = ChallengeCreateModel();
  }
}

class ChallengeCreateModel {
  final int? imageIndex;
  final String? challengeName;
  final double? distance;
  final DateTime? startDate; // Change type to DateTime?
  final DateTime? endDate; // Change type to DateTime?

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
    DateTime? startDate, // Change type to DateTime?
    DateTime? endDate, // Change type to DateTime?
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
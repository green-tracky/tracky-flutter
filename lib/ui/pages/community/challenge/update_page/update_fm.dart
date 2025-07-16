import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/repository/ChallengeRepository.dart';

class ChallengeUpdateForm {
  final int? id;
  final String name;
  final double? distance;
  final String? startDate;
  final String? endDate;

  ChallengeUpdateForm({
    this.id,
    this.name = '',
    this.distance,
    this.startDate,
    this.endDate,
  });

  ChallengeUpdateForm copyWith({
    int? id,
    String? name,
    double? distance,
    String? startDate,
    String? endDate,
  }) {
    return ChallengeUpdateForm(
      id: id ?? this.id,
      name: name ?? this.name,
      distance: distance ?? this.distance,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  factory ChallengeUpdateForm.fromMap(Map<String, dynamic> map) {
    return ChallengeUpdateForm(
      id: map['id'],
      name: map['title'],
      distance: (map['targetDistance'] ?? 0).toDouble(),
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}

class ChallengeUpdateFM extends Notifier<ChallengeUpdateForm> {
  @override
  ChallengeUpdateForm build() => ChallengeUpdateForm();

  Future<void> initForm(int challengeId) async {
    try {
      final response = await ChallengeRepository().getChallengeDetailById(
        challengeId,
      );
      final data = response['data'];

      state = ChallengeUpdateForm.fromMap(data);
    } catch (e) {
      debugPrint('챌린지 상세 불러오기 실패: $e');
    }
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  Future<int?> submit({
    required int challengeId,
    required String name,
  }) async {
    try {
      final response = await ChallengeRepository().updateChallenge(
        challengeId,
        name,
      );

      final data = response['data'];
      state = ChallengeUpdateForm.fromMap(data); // ← 상태에 id 반영
      debugPrint('서버 응답: $data');

      return state.id;
    } catch (e) {
      debugPrint('업데이트 실패: $e');
      return null;
    }
  }
}

final challengeUpdateFMProvider =
    NotifierProvider<ChallengeUpdateFM, ChallengeUpdateForm>(
      () => ChallengeUpdateFM(),
    );

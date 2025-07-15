// lib/ui/pages/run/detail_page/detail_page_vm.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

/// 러닝 상세 정보를 위한 상태 모델
class RunDetailModel {
  final int id;
  final String title;
  final String memo;
  final int intensity;
  final String place;

  RunDetailModel({
    required this.id,
    required this.title,
    required this.memo,
    required this.intensity,
    required this.place,
  });

  factory RunDetailModel.fromMap(Map<String, dynamic> data) {
    return RunDetailModel(
      id: data['id'],
      title: data['title'] ?? "",
      memo: data['memo'] ?? "",
      intensity: data['intensity'] ?? 1,

      place: data['place'] ?? "트랙",
    );
  }

  RunDetailModel copyWith({
    int? id,
    String? title,
    String? memo,
    int? intensity,
    String? place,
  }) {
    return RunDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      memo: memo ?? this.memo,
      intensity: intensity ?? this.intensity,
      place: place ?? this.place,
    );
  }
}

/// Provider
final runDetailProvider = AutoDisposeNotifierProvider<RunDetailVM, RunDetailModel?>(() {
  return RunDetailVM();
});

class RunDetailVM extends AutoDisposeNotifier<RunDetailModel?> {
  @override
  RunDetailModel? build() {
    ref.keepAlive(); // 강제 유지
    return null;
  }

  /// 서버 응답에서 ID만 파싱해서 상태 갱신
  void setFromServerResponse(Map<String, dynamic> response) {
    final data = response['data'];
    if (data != null && data['id'] != null) {
      print('✅ 서버 응답 ID 저장: ${data['id']}');
      state = RunDetailModel.fromMap(data);
      print(state!.id);
    } else {
      print('❌ 서버 응답에 ID 없음');
    }
  }

  /// 직접 runId만 수동 저장
  void setRunId(int runId) {
    state = RunDetailModel(
      id: runId,
      title: "",
      memo: "",
      intensity: 1,
      place: "트랙",
    );
  }

  /// 제목 수정
  Future<void> updateTitle(int runId, String newTitle) async {
    if (runId == null) {
      print('❌ updateTitle 실패: runId가 null');
      return;
    }
    print('📢 updateTitle: "$newTitle" → runId: $runId');
    await RunDetailRepository.instance.patchRunTitle(runId, newTitle);
    print('✅ updateTitle 완료');
  }

  /// 러닝 강도 수정
  Future<void> updateIntensity(int runId, int intensity) async {
    if (runId == null) return;
    await RunDetailRepository.instance.patchRunIntensity(runId, intensity);
  }

  /// 러닝 장소 수정
  Future<void> updatePlace(int runId, String place) async {
    if (runId == null) {
      print('❌ 장소 수정 실패: runId가 null');
      return;
    }
    print('📢 장소 수정 요청: "$place" → runId: $runId');
    await RunDetailRepository.instance.patchRunPlace(runId, place);
    print('✅ 장소 수정 완료');
  }

  /// 러닝 메모 수정
  Future<void> updateMemo(String memo) async {
    final runId = state?.id;
    if (runId == null) return;
    await RunDetailRepository.instance.patchRunMemo(runId, memo);
  }

  Future<void> updateFields(
    int runId, {
    String? title,
    String? memo,
    int? intensity,
    String? place,
  }) async {
    final data = <String, dynamic>{
      'title': title ?? state?.title ?? "",
      'memo': memo ?? state?.memo ?? "",
      'intensity': intensity ?? state?.intensity ?? 1,
      'place': place ?? state?.place ?? "트랙",
    };

    print('📦 PUT 요청: $data');
    await RunDetailRepository.instance.patchRunFields(runId, data);
    print('✅ PUT 완료');
  }
}

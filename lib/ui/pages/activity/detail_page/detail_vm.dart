import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

final activityDetailProvider = AutoDisposeAsyncNotifierProviderFamily<ActivityDetailVM, RunResult?, int>(
  ActivityDetailVM.new,
);

class ActivityDetailVM extends AutoDisposeFamilyAsyncNotifier<RunResult?, int> {
  @override
  Future<RunResult?> build(int runId) async {
    try {
      final response = await RunRepository().getActivityDetailById(runId);
      final data = response['data'];
      final detailModel = RunDetailModel.fromMap(data);
      return detailModel.toRunResult();
    } catch (e, st) {
      print('❌ 활동 상세 로딩 실패: $e');
      print(st);
      rethrow;
    }
  }

  /// 러닝 상세 정보 일부 필드 업데이트 (intensity, place, memo)
  Future<void> updateFields(
      int runId, {
        int? intensity,
        String? place,
        String? memo,
      }) async {
    final fields = <String, dynamic>{};
    if (intensity != null) fields['intensity'] = intensity;
    if (place != null) fields['place'] = place;
    if (memo != null) fields['memo'] = memo;

    try {
      await RunRepository().updateActivity(runId, fields);
      // 업데이트 후, 다시 fetch해서 state 갱신
      final refreshed = await RunRepository().getActivityDetailById(runId);
      final detailModel = RunDetailModel.fromMap(refreshed['data']);
      state = AsyncData(detailModel.toRunResult());
    } catch (e, st) {
      print('❌ 활동 정보 업데이트 실패: $e');
      print(st);
      state = AsyncError(e, st);
    }
  }
}

class RunDetailModel {
  final int id;
  final String title;
  final String? memo;
  final int calories;
  final int totalDistanceMeters;
  final int totalDurationSeconds;
  final int avgPace;
  final int bestPace;
  final int userId;
  final DateTime createdAt;
  final int? intensity;
  final String? place;
  final List<RunSegmentModel> segments;
  final List<RunPicture> pictures;

  RunDetailModel({
    required this.id,
    required this.title,
    this.memo,
    required this.calories,
    required this.totalDistanceMeters,
    required this.totalDurationSeconds,
    required this.avgPace,
    required this.bestPace,
    required this.userId,
    required this.createdAt,
    this.intensity,
    this.place,
    required this.segments,
    required this.pictures,
  });

  factory RunDetailModel.fromMap(Map<String, dynamic> json) {
    return RunDetailModel(
      id: json['id'],
      title: json['title'],
      memo: json['memo'],
      calories: json['calories'],
      totalDistanceMeters: json['totalDistanceMeters'],
      totalDurationSeconds: json['totalDurationSeconds'],
      avgPace: json['avgPace'],
      bestPace: json['bestPace'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      intensity: json['intensity'],
      place: json['place'],
      segments: (json['segments'] as List)
          .map((e) => RunSegmentModel.fromMap(e))
          .toList(),
      pictures: (json['pictures'] as List?)?.map((e) => RunPicture.fromJson(e)).toList() ?? [],
    );
  }
}

class RunSegmentModel {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final int durationSeconds;
  final int distanceMeters;
  final int pace;
  final List<RunCoordinate> coordinates;

  RunSegmentModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.durationSeconds,
    required this.distanceMeters,
    required this.pace,
    required this.coordinates,
  });

  factory RunSegmentModel.fromMap(Map<String, dynamic> json) {
    return RunSegmentModel(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      durationSeconds: json['durationSeconds'],
      distanceMeters: json['distanceMeters'],
      pace: json['pace'],
      coordinates: (json['coordinates'] as List)
          .map((e) => RunCoordinate.fromJson(e))
          .toList(),
    );
  }
}

extension RunDetailModelMapper on RunDetailModel {
  RunResult toRunResult() {
    return RunResult(
      id: id,
      title: title,
      calories: calories,
      totalDistanceMeters: totalDistanceMeters,
      totalDurationSeconds: totalDurationSeconds,
      avgPace: avgPace,
      bestPace: bestPace,
      userId: userId,
      createdAt: createdAt,
      segments: segments.map((seg) => RunSegment(
        id: seg.id,
        startDate: seg.startDate,
        endDate: seg.endDate,
        distanceMeters: seg.distanceMeters,
        durationSeconds: seg.durationSeconds,
        pace: seg.pace,
        coordinates: seg.coordinates,
      )).toList(),
      intensity: intensity,
      memo: memo,
      place: place == null ? null : getSurfaceFromLabel(place!),
      pictures: pictures,
    );
  }
}

final runningSurfaceProvider = StateProvider<RunningSurface?>(
      (ref) => null,
); // 러닝 장소
final runMemoProvider = StateProvider<String>((ref) => ''); // 메모
final runIntensityProvider = StateProvider<int?>((ref) => null); // 러닝 강도
final runResultProvider = StateProvider<RunResult?>(
      (ref) => null,
); // 일시정지 눌렀을 때 받아오는 값

import 'package:tracky_flutter/data/model/Run.dart';

class RunResultBuilder {
  static RunResult build({
    required List<RunSegment> segments,
    required String title,
    required int userId,
    required DateTime createdAt,
    String? memo,
    RunningSurface? place,
    int? intensity,
    List<RunPicture> pictures = const [],
  }) {
    final totalDistance = segments.fold(0, (sum, s) => sum + s.distanceMeters);
    final totalDuration = segments.fold(0, (sum, s) => sum + s.durationSeconds);
    final avgPace = totalDistance == 0 ? 0 : (totalDuration / (totalDistance / 1000)).round();
    final bestPace = segments.isEmpty ? 0 : segments.map((s) => s.pace).reduce((a, b) => a < b ? a : b);

    return RunResult(
      id: 0, // 저장 전
      title: title,
      calories: _estimateCalories(totalDuration),
      totalDistanceMeters: totalDistance,
      totalDurationSeconds: totalDuration,
      // elapsedTimeInSeconds: totalDuration,
      avgPace: avgPace,
      bestPace: bestPace,
      userId: userId,
      segments: segments,
      createdAt: createdAt,
      intensity: intensity,
      memo: memo,
      place: place,
      pictures: pictures,
    );
  }

  static int _estimateCalories(int seconds) {
    return ((seconds / 600) * 60).round();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

final activityProvider =
    AutoDisposeNotifierProvider<ActivityVM, ActivityModel?>(
      () => ActivityVM(),
    );

class ActivityVM extends AutoDisposeNotifier<ActivityModel?> {
  @override
  ActivityModel? build() {
    return null; // 초기 상태 null
  }

  Future<void> loadWeek() async {
    final json = await RunRepository().getWeekActivities();
    state = ActivityModel.fromMap(json['data']);
  }

  Future<void> loadMonth() async {
    final json = await RunRepository().getMonthActivities();
    state = ActivityModel.fromMap(json['data']);
  }

  Future<void> loadYear() async {
    final json = await RunRepository().getYearActivities();
    state = ActivityModel.fromMap(json['data']);
  }

  Future<void> loadAll() async {
    final json = await RunRepository().getAllActivities();
    state = ActivityModel.fromMap(json['data']);
  }
}

class ActivityModel {
  final AvgStats avgStats;
  final List<Map<String, dynamic>> achievementHistory;
  final List<Map<String, dynamic>> recentRuns;
  final RunLevel runLevel;

  ActivityModel({
    required this.avgStats,
    required this.achievementHistory,
    required this.recentRuns,
    required this.runLevel,
  });

  factory ActivityModel.fromMap(Map<String, dynamic> data) {
    return ActivityModel(
      avgStats: AvgStats.fromMap(data['avgStats'] ?? {}),
      achievementHistory: List<Map<String, dynamic>>.from(
        data['achievementHistory'] ?? [],
      ),
      recentRuns: List<Map<String, dynamic>>.from(data['recentRuns'] ?? []),
      runLevel: RunLevel.fromMap(data['runLevel'] ?? {}),
    );
  }
}

class AvgStats {
  final int recodeCount;
  final int avgPace;
  final int totalDistanceMeters;
  final int totalDurationSeconds;

  AvgStats({
    required this.recodeCount,
    required this.avgPace,
    required this.totalDistanceMeters,
    required this.totalDurationSeconds,
  });

  factory AvgStats.fromMap(Map<String, dynamic> map) {
    return AvgStats(
      recodeCount: map['recodeCount'] ?? 0,
      avgPace: map['avgPace'] ?? 0,
      totalDistanceMeters: map['totalDistanceMeters'] ?? 0,
      totalDurationSeconds: map['totalDurationSeconds'] ?? 0,
    );
  }
}

class RunLevel {
  final int totalDistance;
  final int distanceToNextLevel;
  final String name;

  RunLevel({
    required this.totalDistance,
    required this.distanceToNextLevel,
    required this.name,
  });

  factory RunLevel.fromMap(Map<String, dynamic> map) {
    return RunLevel(
      totalDistance: map['totalDistance'] ?? 0,
      distanceToNextLevel: map['distanceToNextLevel'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}

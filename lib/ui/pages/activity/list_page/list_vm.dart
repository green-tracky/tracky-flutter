// running_list_vm.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

final runningListProvider =
AsyncNotifierProvider<RunningListVM, List<Run>>(RunningListVM.new);

class RunningListVM extends AsyncNotifier<List<Run>> {
  @override
  Future<List<Run>> build() async {
    final response = await RunRepository().getAllRunRecords(); // Dio 요청
    final list = response['data']['groupedRecentList'] as List;
    if (list.isEmpty) return [];

    final recentRuns = list.first['recentRuns'] as List;
    return recentRuns.map((e) => Run.fromMap(e)).toList();
  }
}


// run_model.dart
class Run {
  final int id;
  final String title;
  final double distance;
  final int durationSeconds;
  final int avgPace;
  final DateTime createdAt;
  final List<Badge> badges;

  Run({
    required this.id,
    required this.title,
    required this.distance,
    required this.durationSeconds,
    required this.avgPace,
    required this.createdAt,
    required this.badges,
  });

  factory Run.fromMap(Map<String, dynamic> map) => Run(
    id: map['id'],
    title: map['title'],
    distance: (map['totalDistanceMeters'] as num) / 1000,
    durationSeconds: map['totalDurationSeconds'],
    avgPace: map['avgPace'],
    createdAt: DateTime.parse(map['createdAt']),
    badges: (map['badges'] as List)
        .map((e) => Badge.fromMap(e))
        .toList(),
  );
}

class Badge {
  final int id;
  final String name;
  final String imageUrl;

  Badge({required this.id, required this.name, required this.imageUrl});

  factory Badge.fromMap(Map<String, dynamic> map) => Badge(
    id: map['id'],
    name: map['name'],
    imageUrl: map['imageUrl'],
  );
}

class RunGroup {
  final DateTime yearMonth;
  final List<Run> recentRuns;

  RunGroup({required this.yearMonth, required this.recentRuns});

  factory RunGroup.fromMap(Map<String, dynamic> map) => RunGroup(
    yearMonth: DateTime.parse(map['yearMonth']),
    recentRuns:
    (map['recentRuns'] as List).map((e) => Run.fromMap(e)).toList(),
  );

  static List<RunGroup> fromList(List<dynamic> list) =>
      list.map((e) => RunGroup.fromMap(e)).toList();
}


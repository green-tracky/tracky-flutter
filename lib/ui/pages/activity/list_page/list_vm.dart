import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

final runningListProvider = AsyncNotifierProvider<RunningListVM, List<Run>>(RunningListVM.new);

class RunningListVM extends AsyncNotifier<List<Run>> {
  @override
  Future<List<Run>> build() async {
    return _fetch();
  }

  String _mapSortToQuery(String sort) {
    switch (sort) {
      case '최신순':
        return 'latest';
      case '오래된 순':
        return 'oldest';
      case '최장 거리':
        return 'distance-desc';
      case '최단 거리':
        return 'distance-asc';
      case '최고 페이스':
        return 'pace-asc';
      case '최저 페이스':
        return 'pace-desc';
      default:
        return 'latest'; // 기본값
    }
  }

  Future<void> fetchRuns({String? sort, int? year}) async {
    state = const AsyncLoading();

    try {
      final response = await RunRepository().getFilteredRunRecords(
        sort: sort != null ? _mapSortToQuery(sort) : null,
        year: year,
      );
      final data = response['data'];
      List<Run> runs;

      if (data.containsKey('groupedRecentList')) {
        // 최신순, 오래된순
        final groupedList = data['groupedRecentList'] as List;
        final allRuns = groupedList.expand((e) => e['recentRuns'] as List).toList();
        runs = allRuns.map((e) => Run.fromMap(e)).toList();
      } else if (data.containsKey('recentList')) {
        // 거리순, 페이스순
        final recentRuns = data['recentList'] as List;
        runs = recentRuns.map((e) => Run.fromMap(e)).toList();
      } else {
        runs = [];
      }

      state = AsyncData(runs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<List<Run>> _fetch() async {
    final response = await RunRepository().getAllRunRecords();
    final data = response['data'];
    final groupedList = data['groupedRecentList'] as List;
    if (groupedList.isEmpty) return [];

    final allRuns = groupedList.expand((e) => e['recentRuns'] as List).toList();
    return allRuns.map((e) => Run.fromMap(e)).toList();
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
    badges: (map['badges'] as List).map((e) => Badge.fromMap(e)).toList(),
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
    recentRuns: (map['recentRuns'] as List).map((e) => Run.fromMap(e)).toList(),
  );

  static List<RunGroup> fromList(List<dynamic> list) => list.map((e) => RunGroup.fromMap(e)).toList();
}

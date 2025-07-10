import 'dart:async';

import '../model/Run.dart';

class RunRepository {
  final List<Run> _fakeRuns = [
    Run(
      distance: 3.75,
      time: 15,
      isRunning: true ,
      createdAt: DateTime.now(),
      userId: 1,
    ),
  ];

  Future<Run> getOneRun(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('[Repository] getOneRun() 호출됨');
    return _fakeRuns.first;
  }

  Future<List<Run>> getAllRuns() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_fakeRuns);
  }

  Future<RunResult> saveRun(RunResult runResult) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('[RunRepository] saveRun: ${runResult.toJson()}');
    return runResult;
  }

  Future<Run> updateRun(Run run) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fakeRuns[0] = run;
    print('[RunRepository] updateRun: ${run.toJson()}');
    return run;
  }

  Future<void> deleteRun() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final removed = _fakeRuns.removeAt(0);
    print('[RunRepository] deleteRun: ${removed.toJson()}');
  }
}

// ───────────────────────────────────────────────
// RunDetailRepository (러닝 상세 조회 및 수정)
// ───────────────────────────────────────────────

class RunDetailRepository {
  static final RunDetailRepository instance = RunDetailRepository._();
  RunDetailRepository._();

  /// 단일 러닝 결과 조회 (모의 데이터)
  Future<RunResult> getOneRun(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return RunResult.fromJson(_mockRunData['data']);
  }

  /// 러닝 제목 수정 (PATCH)
  Future<void> patchRunTitle(int id, String newTitle) async {
    print('[RunDetailRepository] 제목 PATCH 요청: id=$id, newTitle=$newTitle');
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: 실제 API 연동 예시
    // final res = await dio.patch('/runs/$id', data: {'title': newTitle});
  }
}

/// 모의 러닝 상세 JSON 데이터
const Map<String, dynamic> _mockRunData = {
  'status': 200,
  'msg': '성공',
  'data': {
    'id': 1,
    'title': '부산 서면역 15번 출구 100m 러닝',
    'memo': '서면역 15번 출구에서 NC백화점 방향으로 100m 직선 러닝',
    'calories': 10,
    'totalDistanceMeters': 100,
    'totalDurationSeconds': 50,
    'elapsedTimeInSeconds': 50,
    'avgPace': 500,
    'bestPace': 500,
    'userId': 1,
    'segments': [
      {
        'id': 1,
        'startDate': '2025-06-20 09:00:00',
        'endDate': '2025-06-20 09:00:50',
        'durationSeconds': 50,
        'distanceMeters': 100,
        'pace': 500,
        'coordinates': [
          {'lat': 35.1579, 'lon': 129.0594, 'recordedAt': '2025-06-20 09:00:00'},
          {'lat': 35.1579, 'lon': 129.06053636, 'recordedAt': '2025-06-20 09:00:50'},
        ],
      },
    ],
    'pictures': [],
    'createdAt': '2025-06-20 09:00:50',
    'intensity': 3,
    'place': '도로',
  },
};

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../model/Run.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: kIsWeb
        ? 'http://localhost:8080/s/api' // 웹
        : 'http://10.0.2.2:8080/s/api', // 에뮬레이터
    headers: {'Content-Type': 'application/json'},
  ),
);

class RunRepository {
  // 러닝 레벨 데이터 호출
  Future<Map<String, dynamic>> getRunLevelData() async {
    // 실제 API 호출로 대체해주세요
    // 예: final response = await dio.get('/api/run-level');
    await Future.delayed(const Duration(milliseconds: 300)); // 테스트용 딜레이

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "runLevels": [
          {
            "id": 1,
            "name": "옐로우",
            "minDistance": 0,
            "maxDistance": 49999,
            "description": "0 ~ 49.99킬로미터",
            "imageUrl": "https://example.com/images/yellow.png",
            "sortOrder": 0,
            "isCurrent": true,
          },
          {
            "id": 2,
            "name": "오렌지",
            "minDistance": 50000,
            "maxDistance": 249999,
            "description": "50.00 ~ 249.9킬로미터",
            "imageUrl": "https://example.com/images/orange.png",
            "sortOrder": 1,
            "isCurrent": false,
          },
          {
            "id": 3,
            "name": "그린",
            "minDistance": 250000,
            "maxDistance": 999999,
            "description": "250.0 ~ 999.9킬로미터",
            "imageUrl": "https://example.com/images/green.png",
            "sortOrder": 2,
            "isCurrent": false,
          },
          {
            "id": 4,
            "name": "블루",
            "minDistance": 1000000,
            "maxDistance": 2499000,
            "description": "1,000 ~ 2,499킬로미터",
            "imageUrl": "https://example.com/images/blue.png",
            "sortOrder": 3,
            "isCurrent": false,
          },
        ],
        "totalDistance": 9850,
        "distanceToNextLevel": 40150,
      },
    };

    return dummyResponse;
  }

  final List<Run> _fakeRuns = [
    Run(
      distance: 3.75,
      time: 15,
      isRunning: true,
      createdAt: DateTime.now(),
      userId: 1,
    ),
  ];

  Future<Run> getOneRun(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _fakeRuns.first;
  }

  Future<List<Run>> getAllRuns() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_fakeRuns);
  }

  /// 로컬 저장용 (Mock)
  Future<RunResult> saveRun(RunResult runResult) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return runResult;
  }

  /// 서버에 POST 저장 후 RunResult 반환
  Future<Map<String, dynamic>> saveRunToServer(RunResult runResult) async {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    final body = {
      "title": runResult.title,
      "calories": runResult.calories,
      "segments": runResult.segments
          .map(
            (s) => {
              "startDate": dateFormat.format(s.startDate),
              "endDate": dateFormat.format(s.endDate),
              "durationSeconds": s.durationSeconds,
              "distanceMeters": s.distanceMeters,
              "pace": s.pace,
              "coordinates": s.coordinates
                  .map(
                    (c) => {
                      "lat": c.lat,
                      "lon": c.lon,
                      "recordedAt": dateFormat.format(c.recordedAt),
                    },
                  )
                  .toList(),
            },
          )
          .toList(),
      "pictures": runResult.pictures
          .map(
            (p) => {
              "fileUrl": p.fileUrl,
              "lat": p.lat,
              "lon": p.lon,
              "savedAt": dateFormat.format(p.savedAt),
            },
          )
          .toList(),
      "memo": runResult.memo,
      "place": runResult.place?.label,
      "intensity": runResult.intensity,
    };

    final res = await dio.post('/runs', data: body);
    print('[서버응답] ${res.statusCode} ${res.data}');
    return res.data;
  }

  Future<Run> updateRun(Run run) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fakeRuns[0] = run;
    return run;
  }

  Future<void> deleteRun() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fakeRuns.removeAt(0);
  }
}

// ───────────────────────────────────────────────
// RunDetailRepository (러닝 상세 조회 및 수정)
// ───────────────────────────────────────────────

class RunDetailRepository {
  static final RunDetailRepository instance = RunDetailRepository._();

  RunDetailRepository._();

  /// 단일 러닝 결과 조회 (서버 요청)
  Future<RunResult> getOneRun(int id) async {
    final res = await dio.get('/runs/$id');
    return RunResult.fromJson(res.data['data']);
  }

  /// 러닝 필드 일괄 수정 (PATCH)
  Future<void> patchRunFields(int runId, Map<String, dynamic> data) async {
    print('📤 PUT 요청: /runs/$runId - $data');
    await dio.put('/runs/$runId', data: data);
  }

  // 아래 별도의 patch 함수들은 굳이 분리 안 하고, 필요시 patchRunFields로 통일!
  Future<void> patchRunTitle(int runId, String newTitle) async {
    await patchRunFields(runId, {'title': newTitle});
  }

  Future<void> patchRunIntensity(int runId, int intensity) async {
    await patchRunFields(runId, {'intensity': intensity});
  }

  Future<void> patchRunPlace(int runId, String place) async {
    await patchRunFields(runId, {'place': place});
  }

  Future<void> patchRunMemo(int runId, String memo) async {
    await patchRunFields(runId, {'memo': memo});
  }
}

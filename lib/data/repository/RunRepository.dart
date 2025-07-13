import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../model/Run.dart';

final dio = Dio(BaseOptions(
  baseUrl: kIsWeb
      ? 'http://localhost:8080/s/api'  // 웹
      : 'http://10.0.2.2:8080/s/api',  // 에뮬레이터
  headers: {'Content-Type': 'application/json'},
));

class RunRepository {
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
  Future<RunResult> saveRunToServer(RunResult runResult) async {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    final body = {
      "title": runResult.title,
      "calories": runResult.calories,
      "segments": runResult.segments.map((s) => {
        "startDate": dateFormat.format(s.startDate),
        "endDate": dateFormat.format(s.endDate),
        "durationSeconds": s.durationSeconds,
        "distanceMeters": s.distanceMeters,
        "pace": s.pace,
        "coordinates": s.coordinates.map((c) => {
          "lat": c.lat,
          "lon": c.lon,
          "recordedAt": dateFormat.format(c.recordedAt),
        }).toList(),
      }).toList(),
      "pictures": runResult.pictures.map((p) => {
        "fileUrl": p.fileUrl,
        "lat": p.lat,
        "lon": p.lon,
        "savedAt": dateFormat.format(p.savedAt),
      }).toList(),
      "memo": runResult.memo,
      "place": runResult.place?.label,
      "intensity": runResult.intensity,
    };

    final res = await dio.post('/runs', data: body);
    print('[서버응답] ${res.statusCode} ${res.data}');
    return RunResult.fromJson(res.data);
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
    return RunResult.fromJson(res.data);
  }

  /// 러닝 제목 수정 (PATCH)
  Future<void> patchRunTitle(int id, String newTitle) async {
    await dio.patch('/runs/$id', data: {'title': newTitle});
  }
}

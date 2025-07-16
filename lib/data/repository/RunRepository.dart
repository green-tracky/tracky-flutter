import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/utils/dio.dart';

import '../model/Run.dart';

class RunRepository {
  Dio get _dio => dio;

  Future<Map<String, dynamic>> getWeekActivities() async {
    try {
      print('[getWeekActivities] 요청 시작');
      final res = await dio.get('/activities/week');
      print('[getWeekActivities] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getWeekActivities] 성공');
        return map;
      } else {
        print('[getWeekActivities] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getWeekActivities] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<Map<String, dynamic>> getMonthActivities() async {
    try {
      print('[getMonthActivities] 요청 시작');
      final res = await dio.get('/activities/month');
      print('[getMonthActivities] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getMonthActivities] 성공');
        return map;
      } else {
        print('[getMonthActivities] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getMonthActivities] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<Map<String, dynamic>> getYearActivities() async {
    try {
      print('[getYearActivities] 요청 시작');
      final res = await dio.get('/activities/year');
      print('[getYearActivities] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getYearActivities] 성공');
        return map;
      } else {
        print('[getYearActivities] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getYearActivities] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<Map<String, dynamic>> getAllActivities() async {
    try {
      print('[getAllActivities] 요청 시작');
      final res = await dio.get('/activities/all');
      print('[getAllActivities] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getAllActivities] 성공');
        return map;
      } else {
        print('[getAllActivities] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getAllActivities] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  // 러닝 레벨 데이터 호출
  Future<Map<String, dynamic>> getRunLevelData() async {
    try {
      print('[getRunLevelData] 요청 시작');
      final res = await dio.get('/run-levels');
      print('[getRunLevelData] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getRunLevelData] 성공');
        return map;
      } else {
        print('[getRunLevelData] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getRunLevelData] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<Map<String, dynamic>> getRunningBadges() async {
    try {
      print('[getRunningBadges] 요청 시작');
      final res = await dio.get('/run-badges');
      print('[getRunningBadges] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getRunningBadges] 성공');
        return map;
      } else {
        print('[getRunningBadges] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getRunningBadges] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
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

  Future<Map<String, dynamic>> getAllRunRecords({String order = "latest"}) async {
    try {
      print('[getAllRunRecords] 요청 시작');
      final res = await dio.get(
        '/activities/recent',
        queryParameters: {'order': order},
      );
      print('[getAllRunRecords] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getAllRunRecords] 성공');
        return map;
      } else {
        print('[getAllRunRecords] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getAllRunRecords] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<Map<String, dynamic>> getActivityDetailById(int runId) async {
    try {
      print('[getActivityDetailById] 요청 시작 id=$runId');
      final res = await dio.get('/runs/$runId');
      print('[getActivityDetailById] 응답: ${res.data}');
      final map = res.data as Map<String, dynamic>;
      if (map['status'] == 200 && map['data'] != null) {
        print('[getActivityDetailById] 성공');
        return map;
      } else {
        print('[getActivityDetailById] 실패: status=${map['status']}, msg=${map['msg']}');
        throw Exception('오류');
      }
    } catch (e) {
      print('[getActivityDetailById] 네트워크 오류: $e');
      throw Exception('네트워크 오류');
    }
  }

  Future<void> updateActivity(int runId, Map<String, dynamic> fields) async {
    try {
      await dio.put('/runs/$runId', data: fields);
    } catch (e) {
      print("에러 발생 : $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getFilteredRunRecords({String? sort, int? year}) async {
    final response = await dio.get(
      '/activities/recent',
      queryParameters: {
        if (sort != null) 'order': sort,
        if (year != null) 'year': year,
      },
    );
    return response.data;
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

import 'package:tracky_flutter/data/model/Run.dart';

class RunRepository {
  Future<void> saveRun(Run run) async {
    // 나중에 서버 연동 예정
    print('[RunRepository] 저장할 Run 데이터: ${run.toJson()}');

    // TODO: 서버 연동 시 아래와 같이 사용
    // final response = await dio.post('/runs', data: run.toJson());
  }
}

class RunDetailRepository {
  static final RunDetailRepository instance = RunDetailRepository._();
  RunDetailRepository._();

  Future<RunResult> getOneRun(int id) async {
    // 실제 API 호출이 들어올 자리에 delay
    await Future.delayed(Duration(milliseconds: 300));
    return RunResult.fromJson(_mockRunData['data']);
  }
}

// 아래는 실제 응답 JSON
final Map<String, dynamic> _mockRunData = {
  "status": 200,
  "msg": "성공",
  "data": {
    "id": 1,
    "title": "부산 서면역 15번 출구 100m 러닝",
    "memo": "서면역 15번 출구에서 NC백화점 방향으로 100m 직선 러닝",
    "calories": 10,
    "totalDistanceMeters": 100,
    "totalDurationSeconds": 50,
    "elapsedTimeInSeconds": 50,
    "avgPace": 500,
    "bestPace": 500,
    "userId": 1,
    "segments": [
      {
        "id": 1,
        "startDate": "2025-06-20 09:00:00",
        "endDate": "2025-06-20 09:00:50",
        "durationSeconds": 50,
        "distanceMeters": 100,
        "pace": 500,
        "coordinates": [
          {"lat": 35.1579, "lon": 129.0594, "recordedAt": "2025-06-20 09:00:00"},
          {"lat": 35.1579, "lon": 129.06053636, "recordedAt": "2025-06-20 09:00:50"},
        ],
      },
    ],
    "pictures": [],
    "createdAt": "2025-06-20 09:00:50",
    "intensity": 3,
    "place": "도로",
  },
};

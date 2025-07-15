class RunRepository {
  Future<Map<String, dynamic>> getWeekActivities() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 테스트용 딜레이

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "avgStats": {
          "recodeCount": 2,
          "avgPace": 348,
          "totalDistanceMeters": 7400,
          "totalDurationSeconds": 2580,
        },
        "achievementHistory": [
          {
            "type": "챌린지 수상자",
            "name": "금메달",
            "description": "챌린지에서 1위를 달성하셨습니다!",
            "imageUrl": "https://example.com/rewards/gold.png",
            "achievedAt": "2025-06-16 00:01:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "챌린지 우승자",
            "name": "완주자",
            "description": "챌린지를 완료하셨습니다!",
            "imageUrl": "https://example.com/rewards/participation.png",
            "achievedAt": "2025-06-14 10:00:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "월간업적",
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "achievedAt": "2025-03-15 10:00:00",
            "achievedCount": 4,
            "runRecordDistance": 600,
            "runRecordSeconds": 270,
            "runRecordPace": 450,
            "isAchieved": true,
          },
        ],
        "recentRuns": [
          {
            "id": 16,
            "title": "트랙 러닝 15",
            "totalDistanceMeters": 1900,
            "totalDurationSeconds": 660,
            "avgPace": 347,
            "createdAt": "2025-06-24 00:00:00",
            "badges": [ ]
    },
          {
            "id": 15,
            "title": "트레일 러닝 14",
            "totalDistanceMeters": 1800,
            "totalDurationSeconds": 630,
            "avgPace": 350,
            "createdAt": "2025-06-23 00:00:00",
            "badges": [
              {
                "id": 1,
                "name": "첫 시작",
                "imageUrl": "https://example.com/badges/first_run.png",
              },
            ],
          },
          {
            "id": 14,
            "title": "6월 러닝 13",
            "totalDistanceMeters": 1700,
            "totalDurationSeconds": 600,
            "avgPace": 352,
            "createdAt": "2025-06-22 00:00:00",
            "badges": [ ]
    },
        ],
        "runLevel": {
          "totalDistance": 17600,
          "distanceToNextLevel": 32400,
          "name": "옐로우",
        },
        "weeks": {
          "2025-06": ["06.09~06.15", "06.16~06.22", "06.23~06.29"],
        },
      },
    };
    return dummyResponse;
  }

  Future<Map<String, dynamic>> getMonthActivities() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 테스트용 딜레이

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "avgStats": {
          "recodeCount": 15,
          "avgPace": 372,
          "totalDistanceMeters": 35200,
          "totalDurationSeconds": 13120,
        },
        "achievementHistory": [
          {
            "type": "챌린지 수상자",
            "name": "금메달",
            "description": "챌린지에서 1위를 달성하셨습니다!",
            "imageUrl": "https://example.com/rewards/gold.png",
            "achievedAt": "2025-06-16 00:01:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "챌린지 우승자",
            "name": "완주자",
            "description": "챌린지를 완료하셨습니다!",
            "imageUrl": "https://example.com/rewards/participation.png",
            "achievedAt": "2025-06-14 10:00:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "월간업적",
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "achievedAt": "2025-03-15 10:00:00",
            "achievedCount": 4,
            "runRecordDistance": 600,
            "runRecordSeconds": 270,
            "runRecordPace": 450,
            "isAchieved": true,
          },
        ],
        "recentRuns": [
          {
            "id": 16,
            "title": "트랙 러닝 15",
            "totalDistanceMeters": 1900,
            "totalDurationSeconds": 660,
            "avgPace": 347,
            "createdAt": "2025-06-24 00:00:00",
            "badges": [ ]
    },
          {
            "id": 15,
            "title": "트레일 러닝 14",
            "totalDistanceMeters": 1800,
            "totalDurationSeconds": 630,
            "avgPace": 350,
            "createdAt": "2025-06-23 00:00:00",
            "badges": [
              {
                "id": 1,
                "name": "첫 시작",
                "imageUrl": "https://example.com/badges/first_run.png",
              },
            ],
          },
          {
            "id": 14,
            "title": "6월 러닝 13",
            "totalDistanceMeters": 1700,
            "totalDurationSeconds": 600,
            "avgPace": 352,
            "createdAt": "2025-06-22 00:00:00",
            "badges": [ ]
    },
        ],
        "runLevel": {
          "totalDistance": 17600,
          "distanceToNextLevel": 32400,
          "name": "옐로우",
        },
        "years": [2025],
        "mounts": {
          "2025": [6],
        },
      },
    };
    return dummyResponse;
  }

  Future<Map<String, dynamic>> getYearActivities() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 테스트용 딜레이

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "avgStats": {
          "recodeCount": 15,
          "avgPace": 372,
          "totalDistanceMeters": 35200,
          "totalDurationSeconds": 13120,
        },
        "totalStats": {
          "runCountPerWeek": 0.2,
          "avgPace": 372,
          "avgDistanceMetersPerRun": 1173,
          "avgDurationSecondsPerRun": 437,
        },
        "achievementHistory": [
          {
            "type": "챌린지 수상자",
            "name": "금메달",
            "description": "챌린지에서 1위를 달성하셨습니다!",
            "imageUrl": "https://example.com/rewards/gold.png",
            "achievedAt": "2025-06-16 00:01:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "챌린지 우승자",
            "name": "완주자",
            "description": "챌린지를 완료하셨습니다!",
            "imageUrl": "https://example.com/rewards/participation.png",
            "achievedAt": "2025-06-14 10:00:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "월간업적",
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "achievedAt": "2025-03-15 10:00:00",
            "achievedCount": 4,
            "runRecordDistance": 600,
            "runRecordSeconds": 270,
            "runRecordPace": 450,
            "isAchieved": true,
          },
        ],
        "recentRuns": [
          {
            "id": 16,
            "title": "트랙 러닝 15",
            "totalDistanceMeters": 1900,
            "totalDurationSeconds": 660,
            "avgPace": 347,
            "createdAt": "2025-06-24 00:00:00",
            "badges": [ ]
    },
          {
            "id": 15,
            "title": "트레일 러닝 14",
            "totalDistanceMeters": 1800,
            "totalDurationSeconds": 630,
            "avgPace": 350,
            "createdAt": "2025-06-23 00:00:00",
            "badges": [
              {
                "id": 1,
                "name": "첫 시작",
                "imageUrl": "https://example.com/badges/first_run.png",
              },
            ],
          },
          {
            "id": 14,
            "title": "6월 러닝 13",
            "totalDistanceMeters": 1700,
            "totalDurationSeconds": 600,
            "avgPace": 352,
            "createdAt": "2025-06-22 00:00:00",
            "badges": [ ]
    },
        ],
        "runLevel": {
          "totalDistance": 17600,
          "distanceToNextLevel": 32400,
          "name": "옐로우",
        },
        "years": [2025],
      },
    };
    return dummyResponse;
  }

  Future<Map<String, dynamic>> getAllActivities() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 테스트용 딜레이

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "avgStats": {
          "recodeCount": 15,
          "avgPace": 372,
          "totalDistanceMeters": 17600,
          "totalDurationSeconds": 6560,
        },
        "totalStats": {
          "runCountPerWeek": 5.0,
          "avgPace": 372,
          "avgDistanceMetersPerRun": 1173,
          "avgDurationSecondsPerRun": 437,
        },
        "achievementHistory": [
          {
            "type": "챌린지 수상자",
            "name": "금메달",
            "description": "챌린지에서 1위를 달성하셨습니다!",
            "imageUrl": "https://example.com/rewards/gold.png",
            "achievedAt": "2025-06-16 00:01:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "챌린지 우승자",
            "name": "완주자",
            "description": "챌린지를 완료하셨습니다!",
            "imageUrl": "https://example.com/rewards/participation.png",
            "achievedAt": "2025-06-14 10:00:00",
            "achievedCount": 1,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
          },
          {
            "type": "월간업적",
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "achievedAt": "2025-03-15 10:00:00",
            "achievedCount": 4,
            "runRecordDistance": 600,
            "runRecordSeconds": 270,
            "runRecordPace": 450,
            "isAchieved": true,
          },
        ],
        "recentRuns": [
          {
            "id": 16,
            "title": "트랙 러닝 15",
            "totalDistanceMeters": 1900,
            "totalDurationSeconds": 660,
            "avgPace": 347,
            "createdAt": "2025-06-24 00:00:00",
            "badges": [ ]
    },
          {
            "id": 15,
            "title": "트레일 러닝 14",
            "totalDistanceMeters": 1800,
            "totalDurationSeconds": 630,
            "avgPace": 350,
            "createdAt": "2025-06-23 00:00:00",
            "badges": [
              {
                "id": 1,
                "name": "첫 시작",
                "imageUrl": "https://example.com/badges/first_run.png",
              },
            ],
          },
          {
            "id": 14,
            "title": "6월 러닝 13",
            "totalDistanceMeters": 1700,
            "totalDurationSeconds": 600,
            "avgPace": 352,
            "createdAt": "2025-06-22 00:00:00",
            "badges": [ ]
    },
        ],
        "runLevel": {
          "totalDistance": 17600,
          "distanceToNextLevel": 32400,
          "name": "옐로우",
        },
      },
    };
    return dummyResponse;
  }

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

  Future<Map<String, dynamic>> getRunningBadges() async {
    await Future.delayed(const Duration(milliseconds: 300)); // 테스트용 딜레이

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "recents": [
          {
            "id": 1,
            "name": "금메달",
            "description": "챌린지에서 1위를 달성하셨습니다!",
            "imageUrl": "https://example.com/rewards/gold.png",
            "type": "챌린지 수상자",
            "achievedAt": "2025-06-16 00:01:00",
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
            "achievedCount": 1,
          },
          {
            "id": 4,
            "name": "완주자",
            "description": "챌린지를 완료하셨습니다!",
            "imageUrl": "https://example.com/rewards/participation.png",
            "type": "챌린지 우승자",
            "achievedAt": "2025-06-14 10:00:00",
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
            "achievedCount": 1,
          },
          {
            "id": 1,
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "type": "월간업적",
            "achievedAt": "2025-03-15 10:00:00",
            "runRecordDistance": 600,
            "runRecordSeconds": 270,
            "runRecordPace": 450,
            "isAchieved": true,
            "achievedCount": 4,
          },
          {
            "id": 1,
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "type": "월간업적",
            "achievedAt": "2025-03-15 10:00:00",
            "runRecordDistance": 1800,
            "runRecordSeconds": 630,
            "runRecordPace": 350,
            "isAchieved": true,
            "achievedCount": 4,
          },
          {
            "id": 1,
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "type": "월간업적",
            "achievedAt": "2025-02-15 10:00:00",
            "runRecordDistance": 500,
            "runRecordSeconds": 240,
            "runRecordPace": 480,
            "isAchieved": true,
            "achievedCount": 4,
          },
        ],
        "bests": [
          {
            "id": 2,
            "name": "1K 최고 기록",
            "description": "나의 1,000미터 최고 기록",
            "imageUrl": "https://example.com/badges/1k_best.png",
            "type": "최고기록",
            "achievedAt": null,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": false,
            "achievedCount": null,
          },
          {
            "id": 3,
            "name": "5K 최고 기록",
            "description": "나의 5,000미터 최고 기록",
            "imageUrl": "https://example.com/badges/5k_best.png",
            "type": "최고기록",
            "achievedAt": null,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": false,
            "achievedCount": null,
          },
        ],
        "monthly": [
          {
            "id": 1,
            "name": "첫 시작",
            "description": "매달 첫 러닝을 완료했어요!",
            "imageUrl": "https://example.com/badges/first_run.png",
            "type": "월간업적",
            "achievedAt": "2025-03-15 10:00:00",
            "runRecordDistance": 600,
            "runRecordSeconds": 270,
            "runRecordPace": 450,
            "isAchieved": true,
            "achievedCount": 4,
          },
          {
            "id": 4,
            "name": "브론즈",
            "description": "한 달에 24킬로미터 이상 러닝",
            "imageUrl": "https://example.com/badges/bronze.png",
            "type": "월간업적",
            "achievedAt": null,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": false,
            "achievedCount": null,
          },
          {
            "id": 5,
            "name": "실버",
            "description": "한 달에 40킬로미터 이상 러닝",
            "imageUrl": "https://example.com/badges/silver.png",
            "type": "월간업적",
            "achievedAt": null,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": false,
            "achievedCount": null,
          },
          {
            "id": 6,
            "name": "골드",
            "description": "한 달에 80킬로미터 이상 러닝",
            "imageUrl": "https://example.com/badges/gold.png",
            "type": "월간업적",
            "achievedAt": null,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": false,
            "achievedCount": null,
          },
          {
            "id": 7,
            "name": "플래티넘",
            "description": "한 달에 160킬로미터 이상 러닝",
            "imageUrl": "https://example.com/badges/platinum.png",
            "type": "월간업적",
            "achievedAt": null,
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": false,
            "achievedCount": null,
          },
        ],
        "challenges": [
          {
            "id": 1,
            "name": "금메달",
            "description": "챌린지에서 1위를 달성하셨습니다!",
            "imageUrl": "https://example.com/rewards/gold.png",
            "type": "챌린지 수상자",
            "achievedAt": "2025-06-16 00:01:00",
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
            "achievedCount": 1,
          },
          {
            "id": 4,
            "name": "완주자",
            "description": "챌린지를 완료하셨습니다!",
            "imageUrl": "https://example.com/rewards/participation.png",
            "type": "챌린지 우승자",
            "achievedAt": "2025-06-14 10:00:00",
            "runRecordDistance": null,
            "runRecordSeconds": null,
            "runRecordPace": null,
            "isAchieved": true,
            "achievedCount": 1,
          },
        ],
      },
    };
    return dummyResponse;
  }
}

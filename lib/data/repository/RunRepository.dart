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
}

class ChallengeRepository {
  Future<Map<String, dynamic>> getChallengeDetailById(int id) async {
    // 실제 API 호출 대신 딜레이와 함께 더미 데이터 반환
    await Future.delayed(const Duration(milliseconds: 500));

    // 더미 JSON 응답을 Map으로 정의
    final dummyResponse = {
      "id": 5,
      "name": "6월 100k 챌린지",
      "sub": "이번 달 100km를 달성해보세요!",
      "imageUrl": "https://example.com/rewards/100km_badge.png",
      "myDistance": 17.2,
      "targetDistance": 100.0,
      "remainingTime": 2273983,
      "isInProgress": true,
      "participantCount": 42049,
      "startDate": "2025-06-01",
      "endDate": "2025-06-30",
      "isCreatedByMe": false,
    };

    return dummyResponse;
  }

  Future<Map<String, dynamic>> getChallengeList() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "inviteChallenges": [
          {
            "challengeInfo": {
              "id": 1,
              "imageUrl": "https://example.com/rewards/5km_badge.png",
              "name": "6월 5k 챌린지",
              "sub": "이번 주 5km를 달려보세요.",
              "remainingTime": 691199,
              "myDistance": null,
              "targetDistance": 5000,
              "isInProgress": true,
              "startDate": "2025-06-01 00:00:00",
              "endDate": "2025-06-30 23:59:59",
              "type": "공개",
            },
            "fromUsername": "cos",
            "challengeInviteId": 1,
          },
          {
            "challengeInfo": {
              "id": 2,
              "imageUrl": "https://example.com/rewards/10km_badge.png",
              "name": "6월 15k 챌린지",
              "sub": "6월 한 달 동안 15km를 달성해보세요!",
              "remainingTime": 691199,
              "myDistance": null,
              "targetDistance": 10000,
              "isInProgress": true,
              "startDate": "2025-06-01 00:00:00",
              "endDate": "2025-06-30 23:59:59",
              "type": "공개",
            },
            "fromUsername": "love",
            "challengeInviteId": 2,
          },
        ],
        "recommendedChallenge": {
          "id": 5,
          "name": "6월 100k 챌린지",
          "imageUrl": "https://example.com/rewards/100km_badge.png",
          "participantCount": 0,
          "type": "공개",
        },
        "myChallenges": [
          {
            "id": 1,
            "imageUrl": "https://example.com/rewards/5km_badge.png",
            "name": "6월 5k 챌린지",
            "sub": null,
            "remainingTime": 691199,
            "myDistance": 18100,
            "targetDistance": 5000,
            "isInProgress": true,
            "endDate": null,
            "type": "공개",
          },
          {
            "id": 6,
            "imageUrl": null,
            "name": "가볍게 1km 달리기",
            "sub": null,
            "remainingTime": 0,
            "myDistance": 4500,
            "targetDistance": 1000,
            "isInProgress": true,
            "endDate": null,
            "type": "사설",
          },
        ],
        "joinableChallenges": [
          {
            "id": 2,
            "imageUrl": null,
            "name": "6월 15k 챌린지",
            "sub": "6월 한 달 동안 15km를 달성해보세요!",
            "remainingTime": 691199,
            "myDistance": null,
            "targetDistance": null,
            "isInProgress": true,
            "endDate": null,
            "type": "공개",
          },
          {
            "id": 3,
            "imageUrl": null,
            "name": "6월 25k 챌린지",
            "sub": "6월 한 달 동안 25km를 달성해보세요!",
            "remainingTime": 691199,
            "myDistance": null,
            "targetDistance": null,
            "isInProgress": true,
            "endDate": null,
            "type": "공개",
          },
          {
            "id": 4,
            "imageUrl": null,
            "name": "6월 50k 챌린지",
            "sub": "6월 한 달 동안 50km를 달성해보세요!",
            "remainingTime": 691199,
            "myDistance": null,
            "targetDistance": null,
            "isInProgress": true,
            "endDate": null,
            "type": "공개",
          },
          {
            "id": 5,
            "imageUrl": null,
            "name": "6월 100k 챌린지",
            "sub": "6월 한 달 동안 100km를 달성해보세요!",
            "remainingTime": 691199,
            "myDistance": null,
            "targetDistance": null,
            "isInProgress": true,
            "endDate": null,
            "type": "공개",
          },
        ],
        "pastChallenges": [],
      },
    };

    return dummyResponse;
  }
}

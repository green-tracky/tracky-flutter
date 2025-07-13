class ChallengeRepository {
  Future<Map<String, dynamic>> getChallengeDetailById(int id) async {
    // 실제 API 호출 대신 딜레이와 함께 더미 데이터 반환
    await Future.delayed(const Duration(milliseconds: 500));

    // 더미 JSON 응답을 Map으로 정의
    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "participantCount": 1,
        "myDistance": 3100,
        "isJoined": true,
        "id": 1,
        "name": "6월 5k 챌린지",
        "sub": "이번 주 5km를 달려보세요.",
        "description":
            "주간 챌린지를 통해 나의 한계를 뛰어넘어 보세요. 이번 주 5km를 달리면 특별한 완주자 기록을 달성할 수 있습니다.",
        "startDate": "2025-06-01 00:00:00",
        "endDate": "2025-06-30 23:59:59",
        "targetDistance": 5000,
        "remainingTime": 0,
        "isInProgress": true,
        "creatorName": null,
        "type": "공개",
        "rank": 1,
        "rewards": [
          {
            "rewardName": "6월 5k 챌린지",
            "rewardImageUrl": "https://example.com/rewards/participation.png",
            "status": "달성",
          },
        ],
      },
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

  Future<Map<String, dynamic>> getChallengeLeaderBoardbyId(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": {
        "myRanking": {
          "totalDistanceMeters": 9880,
          "rank": 11,
        },
        "rankingList": [
          {
            "profileUrl": "http://example.com/profiles/mario.jpg",
            "username": "Mario Jose Zambrano",
            "totalDistanceMeters": 36690,
            "rank": 1,
            "userId": 1,
          },
          {
            "profileUrl": "http://example.com/profiles/masami.jpg",
            "username": "Masami Nakada",
            "totalDistanceMeters": 27110,
            "rank": 2,
            "userId": 2,
          },
          {
            "profileUrl": "http://example.com/profiles/muhammad.jpg",
            "username": "Muhammad Rifai",
            "totalDistanceMeters": 19300,
            "rank": 3,
            "userId": 3,
          },
          {
            "profileUrl": "http://example.com/profiles/cynthia.jpg",
            "username": "Cynthia Johnson",
            "totalDistanceMeters": 18760,
            "rank": 4,
            "userId": 4,
          },
          {
            "profileUrl": "http://example.com/profiles/takahiro.jpg",
            "username": "Takahiro NAKASHIMA",
            "totalDistanceMeters": 18240,
            "rank": 5,
            "userId": 5,
          },
          {
            "profileUrl": "http://example.com/profiles/michael.jpg",
            "username": "Michael Pereira",
            "totalDistanceMeters": 13010,
            "rank": 6,
            "userId": 6,
          },
          {
            "profileUrl": "http://example.com/profiles/david.jpg",
            "username": "David Wright",
            "totalDistanceMeters": 12880,
            "rank": 7,
            "userId": 7,
          },
          {
            "profileUrl": "http://example.com/profiles/ace.jpg",
            "username": "Ace Gutter",
            "totalDistanceMeters": 11630,
            "rank": 8,
            "userId": 8,
          },
          {
            "profileUrl": "http://example.com/profiles/robert.jpg",
            "username": "Robert Chang",
            "totalDistanceMeters": 11280,
            "rank": 9,
            "userId": 9,
          },
          {
            "profileUrl": "http://example.com/profiles/don.jpg",
            "username": "Don friend",
            "totalDistanceMeters": 10720,
            "rank": 10,
            "userId": 10,
          },
          {
            "profileUrl": "http://example.com/profiles/lee.jpg",
            "username": "Lee Sun",
            "totalDistanceMeters": 9980,
            "rank": 11,
            "userId": 11,
          },
        ],
      },
    };

    return dummyResponse;
  }
}

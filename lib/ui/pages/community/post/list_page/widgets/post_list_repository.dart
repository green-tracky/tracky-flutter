import 'dart:async';

class PostListRepository {
  Future<List<Map<String, dynamic>>> fetchPostList() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      {
        "id": 1,
        "likeCount": 3,
        "commentCount": 3,
        "isLiked": false,
        "content": "오늘도 힘차게 달려요!!",
        "createdAt": "2025-06-18 17:00",
        "pictures": [
          {"fileUrl": "assets/images/mountain.jpg"},
        ],
        "user": {
          "id": 1,
          "username": "ssar",
          "profileUrl": "http://example.com/profiles/ssar.jpg",
        },
      },
      {
        "id": 2,
        "likeCount": 1,
        "commentCount": 0,
        "isLiked": true,
        "content": "love의 러닝 기록을 공유합니다.",
        "createdAt": "2025-07-13 19:10:00",
        "pictures": [],
        "user": {
          "id": 3,
          "username": "love",
          "profileUrl": "http://example.com/profiles/love.jpg",
        },
      },
    ];
  }
}

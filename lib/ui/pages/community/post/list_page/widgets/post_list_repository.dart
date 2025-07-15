import 'dart:async';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_model.dart';

class PostListRepository {
  Future<List<PostListModel>> fetchPostList() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 더미 딜레이

    final Map<String, dynamic> dummyResponse = {
      "status": 200,
      "msg": "성공",
      "data": [
        {
          "likeCount": 1,
          "commentCount": 3,
          "isLiked": false,
          "id": 1,
          "content": "ssar의 러닝 기록을 공유합니다.",
          "createdAt": "2025-07-13 19:10:00",
          "pictures": [
            {
              "fileUrl": "assets/images/mountain.jpg",
              "lat": 37.5665,
              "lon": 126.978,
              "savedAt": "2025-07-17 08:30:00",
            },
          ],
          "user": {
            "id": 1,
            "username": "ssar",
            "profileUrl": "http://example.com/profiles/ssar.jpg",
          },
        },
        {
          "likeCount": 1,
          "commentCount": 0,
          "isLiked": true,
          "id": 2,
          "content": "love의 러닝 기록을 공유합니다.",
          "createdAt": "2025-07-16 19:10:00",
          "pictures": [],
          "user": {
            "id": 3,
            "username": "love",
            "profileUrl": "http://example.com/profiles/love.jpg",
          },
        },
        {
          "likeCount": 0,
          "commentCount": 0,
          "isLiked": false,
          "id": 3,
          "content": "cos의 러닝 기록을 공유합니다.",
          "createdAt": "2025-07-12 19:10:00",
          "pictures": [],
          "user": {
            "id": 2,
            "username": "cos",
            "profileUrl": "http://example.com/profiles/love.jpg",
          },
        },
        {
          "likeCount": 2,
          "commentCount": 3,
          "isLiked": false,
          "id": 4,
          "content": "ssar의 러닝 기록을 공유합니다.",
          "createdAt": "2025-07-13 19:10:00",
          "pictures": [
            {
              "fileUrl": "assets/images/mountain.jpg",
              "lat": 37.5665,
              "lon": 126.978,
              "savedAt": "2025-07-02 08:30:00",
            },
          ],
          "user": {
            "id": 5,
            "username": "haha",
            "profileUrl": "http://example.com/profiles/ssar.jpg",
          },
        },
      ],
    };

    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(
      dummyResponse['data'],
    );

    return dataList.map((e) => PostListModel.fromMap(e)).toList();
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

import 'widgets/post_card.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  final List<Map<String, dynamic>> posts = const [
    {
      "id": 1,
      "author": "ssar",
      "content": "오늘도 힘차게 달려요!!",
      "createdAt": "2025.06.18 17:00",
      "likesCount": 3,
      "commentsCount": 3,
      "isLiked": false,
      "imageUrl": null,
    },
    {
      "id": 2,
      "author": "cos",
      "content": "오늘 날씨가 좋아서 러닝하기 좋아요",
      "createdAt": "2025.06.17 15:00",
      "likesCount": 2,
      "commentsCount": 2,
      "isLiked": true,
      "imageUrl": null,
    },
    {
      "id": 3,
      "author": "love",
      "content": "러닝하기 좋은 날",
      "createdAt": "2025.06.16 12:00",
      "likesCount": 1,
      "commentsCount": 0,
      "isLiked": false,
      "imageUrl": null,
    },
    {
      "id": 4,
      "author": "haha",
      "content": "덥지만 오늘도 러닝",
      "createdAt": "2025.06.15 14:00",
      "likesCount": 0,
      "commentsCount": 1,
      "isLiked": true,
      "imageUrl": null,
    },
    {
      "id": 5,
      "author": "green",
      "content": "꾸준히 달리기!!",
      "createdAt": "2025.06.14 11:00",
      "likesCount": 5,
      "commentsCount": 2,
      "isLiked": true,
      "imageUrl": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostListAppBar(),
      endDrawer: CommunityDrawer(),
      backgroundColor: Color(0xFFF9FAEB),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16), // 상하 패딩 추가
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Column(
            children: [
              PostCard(
                author: post['author'],
                content: post['content'],
                createdAt: post['createdAt'],
                likesCount: post['likesCount'],
                commentsCount: post['commentsCount'],
                isLiked: post['isLiked'],
                imageUrl: post['imageUrl'],
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/post_detail_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_appbar.dart';
import 'package:tracky_flutter/ui/pages/community/post/save_page/post_save_page.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';
import 'package:tracky_flutter/ui/widgets/common_title.dart';
import 'widgets/post_card.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final List<Map<String, dynamic>> posts = [
    {
      "id": 1,
      "author": "ssar",
      "content": "오늘도 힘차게 달려요!!",
      "createdAt": "2025.06.18 17:00",
      "likesCount": 3,
      "commentsCount": 3,
      "isLiked": false,
      "imageUrls": [
        'assets/images/kb_bank.png',
        'assets/images/kyochon_chicken.png',
        'assets/images/Screenshot_1.png',
        'assets/images/Screenshot_2.png',
      ],
      "thumbnailImage": 'assets/images/mountain.jpg',
    },
    {
      "id": 2,
      "author": "cos",
      "content": "오늘 날씨가 좋아서 러닝하기 좋아요",
      "createdAt": "2025.06.17 15:00",
      "likesCount": 2,
      "commentsCount": 2,
      "isLiked": true,
      "imageUrls": [
        'assets/images/kb_bank.png',
        'assets/images/kyochon_chicken.png',
        'assets/images/Screenshot_1.png',
        'assets/images/Screenshot_2.png',
      ],
      "thumbnailImage": 'assets/images/mountain.jpg',
    },
    {
      "id": 3,
      "author": "love",
      "content": "러닝하기 좋은 날",
      "createdAt": "2025.06.16 12:00",
      "likesCount": 1,
      "commentsCount": 0,
      "isLiked": false,
      "imageUrls": [
        'assets/images/kb_bank.png',
        'assets/images/kyochon_chicken.png',
        'assets/images/Screenshot_1.png',
        'assets/images/Screenshot_2.png',
      ],
      "thumbnailImage": 'assets/images/mountain.jpg',
    },
    {
      "id": 4,
      "author": "haha",
      "content": "덥지만 오늘도 러닝",
      "createdAt": "2025.06.15 14:00",
      "likesCount": 0,
      "commentsCount": 1,
      "isLiked": true,
      "imageUrls": [
        'assets/images/kb_bank.png',
        'assets/images/kyochon_chicken.png',
        'assets/images/Screenshot_1.png',
        'assets/images/Screenshot_2.png',
      ],
      "thumbnailImage": 'assets/images/mountain.jpg',
    },
    {
      "id": 5,
      "author": "green",
      "content": "꾸준히 달리기!!",
      "createdAt": "2025.06.14 11:00",
      "likesCount": 5,
      "commentsCount": 2,
      "isLiked": true,
      "imageUrls": [
        'assets/images/kb_bank.png',
        'assets/images/kyochon_chicken.png',
        'assets/images/Screenshot_1.png',
        'assets/images/Screenshot_2.png',
      ],
      "thumbnailImage": 'assets/images/mountain.jpg',
    },
  ];

  /// ✅ 글 추가 메서드
  void addPost(Map<String, dynamic> post) {
    setState(() {
      posts.insert(0, post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostListAppBar(),
      endDrawer: const CommunityDrawer(),
      backgroundColor: const Color(0xFFF9FAEB),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: posts.length + 1, // 타이틀 때문에 +1
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: CommonTitle(
                title: "커뮤니티",
              ),
            );
          }

          final post = posts[index - 1];

          return PostCard(
            postId: post['id'],
            author: post['author'],
            content: post['content'],
            createdAt: post['createdAt'],
            likesCount: post['likesCount'],
            commentsCount: post['commentsCount'],
            isLiked: post['isLiked'],
            imageUrls: post['imageUrls'] ?? [],
            thumbnailImage: post['thumbnailImage'],
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostDetailPage(
                    postId: post['id'],
                    author: post['author'],
                    content: post['content'],
                    createdAt: post['createdAt'],
                    imageUrls: post['imageUrls'],
                    likeCount: post['likesCount'],
                    commentCount: post['commentsCount'],
                    commentList: dummyComments,
                  ),
                ),
              );

              if (result != null) {
                setState(() {
                  posts.removeWhere((element) => element['id'] == result);
                });
              }
            },
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 66,
        height: 66,
        child: FloatingActionButton(
          backgroundColor: AppColors.trackyNeon,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostSavePage()),
            );
          },
          child: const Icon(
            Icons.edit,
            color: AppColors.trackyIndigo,
            size: Gap.xxlGap,
          ), // 글쓰기 아이콘
        ),
      ),
    );
  }
}

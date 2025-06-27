import 'package:flutter/material.dart';
import 'widgets/post_detail_reply.dart';

// 댓글 더미 데이터
final List<Comment> comments = [
  Comment(
    author: 'cos',
    content: '와 진짜 예뻐요!',
    replies: [
      Comment(
        author: 'ssar',
        content: '직접 가보시면 더 예뻐요!',
      ),
    ],
  ),
  Comment(
    author: 'love',
    content: '힐링됩니다 😊',
  ),
  Comment(
    author: 'green',
    content: '러닝하면서 사진도 찍으시다니!',
    replies: [
      Comment(
        author: 'ssar',
        content: '쉬는 타이밍에 찍었어요 ㅎㅎ',
      ),
    ],
  ),
];

class PostDetailPage extends StatelessWidget {
  final String author;
  final String content;
  final String createdAt;
  final String? imageUrl;
  final int likeCount;
  final int commentCount;
  final List<Comment> comments;

  PostDetailPage({
    super.key,
    required this.author,
    required this.content,
    required this.createdAt,
    this.imageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      // AppBar
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        automaticallyImplyLeading: false,
        // 기본 뒤로가기 버튼 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // 원하는 아이콘으로 변경
          color: Color(0xFF021F59),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 기능 유지
          },
        ),
        title: const Text(
          '커뮤니티',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
        ),
        centerTitle: true,
        // Tune 메뉴 아이콘
        actions: [
          // PopUp (수정, 삭제)
          PopupMenuButton<String>(
            icon: const Icon(Icons.tune, color: Color(0xFF021F59)),
            onSelected: (value) {
              if (value == 'edit') {
                print('수정');
                // Navigator.push(context, ...);
              } else if (value == 'delete') {
                print('삭제');
                // 삭제 기능 실행
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('수정'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('삭제'),
              ),
            ],
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),

          /// 작성자 정보
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFF021F59),
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  author,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                createdAt,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 본문
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 12),

          /// 이미지 or 지도
          AspectRatio(
            aspectRatio: 9 / 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null
                  ? Image.network(imageUrl!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.grey,
                      child: const Center(child: Text('지도 영역')),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          /// 댓글 수, 좋아요
          Row(
            children: [
              const Icon(Icons.comment_outlined, size: 20),
              const SizedBox(width: 4),
              Text('${commentCount}'),
              const SizedBox(width: 16),
              const Icon(Icons.favorite_border, size: 20),
              const SizedBox(width: 4),
              Text('$likeCount'),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 12),

          /// 댓글 리스트
          ...comments.map((c) => commentItem(c)).toList(),

          const SizedBox(height: 50), // 하단 여백
        ],
      ),

      // 🔥 댓글 입력창
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF9FAEB),
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: '댓글을 입력하세요.',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                color: Color(0xFF021F59),
                icon: const Icon(Icons.send),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// 🔥 댓글 위젯

class Comment {
  final String author;
  final String content;
  final List<Comment> replies;

  Comment({
    required this.author,
    required this.content,
    this.replies = const [],
  });
}

Widget commentItem(Comment comment, {double indent = 0}) {
  return Padding(
    padding: EdgeInsets.only(left: indent),
    child: Column(
      children: [
        // 프로필 + 작성자
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF021F59),
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 작성자 이름
                  Text(comment.author, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 4),

                  // 댓글 내용
                  Text(comment.content, style: const TextStyle(fontSize: 14)),

                  // 답글달기 버튼
                  InkWell(
                    onTap: () {
                      // 답글 기능 추가
                      print('[$comment.author]님에게 답글 달기 클릭');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        '답글 달기...',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        /// 🔥 대댓글
        if (comment.replies.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...comment.replies.map((reply) => commentItem(reply, indent: indent + 40)).toList(),
        ],

        /// 🔥 본댓글이면 아래 간격 추가
        if (indent == 0) const SizedBox(height: 16),
      ],
    ),
  );
}

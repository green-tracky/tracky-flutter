import 'package:flutter/material.dart';

class Comment {
  final String author;
  String content;
  final String createdAt;
  List<Comment> replies;
  bool isRepliesExpanded;
  int repliesPage;
  bool isReplying;

  Comment({
    required this.author,
    required this.content,
    required this.createdAt,
    this.replies = const [],
    this.isRepliesExpanded = false,
    this.repliesPage = 1,
    this.isReplying = false,
  });
}

List<Comment> generateReplies() {
  return List.generate(
    15,
    (i) => Comment(
      author: i % 2 == 0 ? 'ssar' : 'user$i',
      content: '대댓글 내용 $i',
      createdAt: '2025.06.30 15:${i.toString().padLeft(2, '0')}',
    ),
  );
}

void showEditDialog(
  BuildContext context,
  Comment comment,
  Function(Comment, String) onEdit,
) {
  final controller = TextEditingController(text: comment.content);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('댓글 수정'),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(hintText: '수정할 내용을 입력하세요'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onEdit(comment, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('수정', style: TextStyle(color: Color(0xFF021F59))),
          ),
        ],
      );
    },
  );
}

void showDeleteConfirmDialog(BuildContext context, VoidCallback onDelete) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('정말 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

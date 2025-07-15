import 'package:flutter/material.dart';

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String username;
  String content;
  final int? parentId;
  final String createdAt;
  List<Comment> children;

  // UI 전용 필드
  bool isRepliesExpanded;
  int repliesPage;
  bool isReplying;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.content,
    required this.parentId,
    required this.createdAt,
    this.children = const [],
    this.isRepliesExpanded = false,
    this.repliesPage = 1,
    this.isReplying = false,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      postId: map['POSTId'],
      userId: map['userId'],
      username: map['username'] ?? '',
      content: map['content'],
      parentId: map['parentId'],
      createdAt: map['createdAt'],
      children: (map['children'] as List<dynamic>?)?.map((e) => Comment.fromMap(e)).toList() ?? [],
    );
  }
}

List<Comment> generateReplies() {
  return List.generate(
    15,
    (i) => Comment(
      username: i % 2 == 0 ? 'ssar' : 'user$i',
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

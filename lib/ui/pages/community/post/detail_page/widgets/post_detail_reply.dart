import 'dart:async';
import 'package:flutter/material.dart';

class Comment {
  final String author;
  String content;
  final String createdAt;
  List<Comment> replies;
  bool isRepliesExpanded;
  int repliesPage;

  Comment({
    required this.author,
    required this.content,
    required this.createdAt,
    this.replies = const [],
    this.isRepliesExpanded = false,
    this.repliesPage = 1,
  });
}

List<Comment> generateReplies() {
  return List.generate(
    11,
    (i) => Comment(
      author: i % 2 == 0 ? 'ssar' : 'user$i',
      content: '대댓글 내용 $i',
      createdAt: '25.06.30 15:0$i',
    ),
  );
}

Widget commentItem(
  BuildContext context,
  Comment comment, {
  double indent = 0,
  int repliesPreviewCount = 5,
  VoidCallback? onToggleReplies,
  required Function(Comment) onDelete,
  required Function(Comment parent) onReply,
  required Function(Comment, String) onEdit,
  required String currentUser,
}) {
  bool isMyComment = comment.author == currentUser;

  final start = 0;
  final end = comment.repliesPage * repliesPreviewCount;
  final visibleReplies = comment.replies.length > end ? comment.replies.sublist(start, end) : comment.replies;

  Timer? longPressTimer;

  return Padding(
    padding: EdgeInsets.only(left: indent, top: 8),
    child: GestureDetector(
      onTapDown: (_) {
        longPressTimer = Timer(const Duration(seconds: 2), () {
          if (isMyComment) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('댓글을 삭제하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('취소'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete(comment);
                      },
                      child: const Text(
                        '삭제',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            showEditDialog(context, comment, onEdit);
          }
        });
      },
      onTapUp: (_) => longPressTimer?.cancel(),
      onTapCancel: () => longPressTimer?.cancel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 상단 프로필, 작성자, 날짜 한줄 정렬
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// 작성자
                    Text(
                      comment.author,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),

                    /// 날짜
                    Text(
                      comment.createdAt,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          /// 🔥 댓글 본문
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.content,
                  style: const TextStyle(fontSize: 14),
                ),
                InkWell(
                  onTap: () {
                    onReply(comment);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '답글 달기',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 대댓글
          if (comment.replies.isNotEmpty && comment.isRepliesExpanded) ...[
            ...visibleReplies.map(
              (reply) => commentItem(
                context,
                reply,
                indent: indent + 40,
                onToggleReplies: onToggleReplies,
                onDelete: (replyComment) {
                  comment.replies.remove(replyComment);
                  onDelete(replyComment);
                },
                onReply: onReply,
                onEdit: onEdit,
                currentUser: currentUser,
              ),
            ),
          ],

          /// 🔥 답글 보기 버튼
          if (!comment.isRepliesExpanded && comment.replies.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: indent + 40),
              child: InkWell(
                onTap: onToggleReplies,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '답글 보기',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

void showEditDialog(BuildContext context, Comment comment, Function(Comment, String) onEdit) {
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onEdit(comment, controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('수정'),
          ),
        ],
      );
    },
  );
}

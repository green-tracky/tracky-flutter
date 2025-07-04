import 'dart:async';
import 'package:flutter/material.dart';
import 'post_detail_reply.dart';

Widget commentItem(
  BuildContext context,
  Comment comment, {
  double indent = 0,
  int repliesPreviewCount = 5,
  VoidCallback? onToggleReplies,
  required Function(Comment) onDelete,
  required Function(Comment) onReply,
  required Function(Comment) onCancelReply,
  required Function(Comment, String) onSendReply,
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
        if (isMyComment) {
          longPressTimer = Timer(const Duration(seconds: 1), () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('댓글을 삭제하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        '취소',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showDeleteConfirmDialog(
                          context,
                          () => onDelete(comment),
                        );
                      },
                      child: const Text(
                        '삭제',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showEditDialog(context, comment, onEdit);
                      },
                      child: const Text(
                        '수정',
                        style: TextStyle(color: Color(0xFF021F59)),
                      ),
                    ),
                  ],
                );
              },
            );
          });
        }
      },
      onTapUp: (_) => longPressTimer?.cancel(),
      onTapCancel: () => longPressTimer?.cancel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFF021F59),
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  comment.author,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                comment.createdAt,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.content, style: const TextStyle(fontSize: 14)),
                InkWell(
                  onTap: () => onReply(comment),
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
                onCancelReply: onCancelReply,
                onSendReply: onSendReply,
                onEdit: onEdit,
                currentUser: currentUser,
              ),
            ),
          ],
          if (comment.replies.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: indent + 40),
              child: InkWell(
                onTap: onToggleReplies,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    comment.isRepliesExpanded ? '접기' : '답글 전체보기',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ),

          if (comment.isReplying)
            Padding(
              padding: EdgeInsets.only(left: indent + 40, top: 4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        onSendReply(comment, value);
                      },
                      decoration: InputDecoration(
                        hintText: '${comment.author}에게 답글 달기...',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            onCancelReply(comment);
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF021F59)),
                    onPressed: () {
                      onSendReply(comment, '');
                    },
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

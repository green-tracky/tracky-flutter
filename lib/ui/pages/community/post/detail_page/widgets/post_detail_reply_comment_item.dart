import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
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
  bool isReply = false,
}) {
  bool isMyComment = comment.author == currentUser;

  final start = 0;
  final end = comment.repliesPage * repliesPreviewCount;
  final visibleReplies = comment.replies.length > end
      ? comment.replies.sublist(start, end)
      : comment.replies;

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
                backgroundColor: AppColors.trackyIndigo,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: Gap.lGap,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  comment.author,
                  style: styleWithColor(
                    AppTextStyles.content,
                    Colors.black,
                  ),
                ),
              ),
              Text(
                comment.createdAt,
                style: styleWithColor(
                  AppTextStyles.plain,
                  Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.content,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                if (!isReply)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onReply(comment),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          '답글',
                          style: styleWithColor(
                            AppTextStyles.plain,
                            Colors.grey,
                          ),
                        ),
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
                isReply: true,
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
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onToggleReplies,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          comment.isRepliesExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: Gap.lGap,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          comment.isRepliesExpanded ? '접기' : '모든 답글',
                          style: styleWithColor(
                            AppTextStyles.plain,
                            Colors.grey,
                          ),
                        ),
                      ],
                    ),
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
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // 기본 색상
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.trackyIndigo,
                          ), // 포커스 색상
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: Gap.mGap,
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
                    icon: Icon(
                      Icons.send,
                      color: AppColors.trackyIndigo,
                      size: Gap.mGap,
                    ),
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

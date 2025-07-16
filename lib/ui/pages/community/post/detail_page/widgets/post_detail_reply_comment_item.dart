import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_vm.dart';

class CommentViewModel {
  final CommentModel comment;
  bool isReplying;
  bool isRepliesExpanded;

  CommentViewModel({
    required this.comment,
    this.isReplying = false,
    this.isRepliesExpanded = false,
  });
}

Widget commentItem(
  BuildContext context,
  CommentViewModel commentVM, {
  double indent = 0,
  int repliesPreviewCount = 5,
  required Function(int) onToggleReplies,
  required Function(int) onDelete,
  required Function(int) onReply,
  required Function(int) onCancelReply,
  required Function(int, String) onSendReply,
  required String currentUser,
  bool isReply = false,
}) {
  final comment = commentVM.comment;
  final start = 0;
  final end = comment.repliesPage * repliesPreviewCount;
  final visibleReplies = comment.children.length > end ? comment.children.sublist(start, end) : comment.children;

  return Padding(
    padding: EdgeInsets.only(left: indent, top: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.trackyIndigo,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                comment.username,
                style: styleWithColor(AppTextStyles.content, Colors.black),
              ),
            ),
            Text(
              comment.createdAt,
              style: styleWithColor(AppTextStyles.plain, Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.content, style: const TextStyle(fontSize: 14, color: Colors.black)),
              if (!isReply)
                InkWell(
                  onTap: () => onReply(comment.id),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '답글',
                      style: styleWithColor(AppTextStyles.plain, Colors.grey),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (comment.children.isNotEmpty && commentVM.isRepliesExpanded) ...[
          ...visibleReplies.map(
            (reply) => commentItem(
              context,
              CommentViewModel(comment: reply),
              indent: indent + 40,
              isReply: true,
              onToggleReplies: onToggleReplies,
              onDelete: onDelete,
              onReply: onReply,
              onCancelReply: onCancelReply,
              onSendReply: onSendReply,
              currentUser: currentUser,
            ),
          ),
        ],
        if (comment.children.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: indent + 40),
            child: InkWell(
              onTap: () => onToggleReplies(comment.id),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      commentVM.isRepliesExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      commentVM.isRepliesExpanded ? '접기' : '모든 답글',
                      style: styleWithColor(AppTextStyles.plain, Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (commentVM.isReplying)
          Padding(
            padding: EdgeInsets.only(left: indent + 40, top: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onSubmitted: (value) => onSendReply(comment.id, value),
                    decoration: InputDecoration(
                      hintText: '${comment.username}에게 답글 달기...',
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.trackyIndigo),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => onCancelReply(comment.id),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.trackyIndigo),
                  onPressed: () => onSendReply(comment.id, ''),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

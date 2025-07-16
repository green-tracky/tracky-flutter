import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_vm.dart';

Widget commentItem(
  BuildContext context,
  CommentModel comment, {
  double indent = 0,
  required Function(int) onToggleReplies,
  required Function(int) onDelete,
  required Function(int) onReply,
}) {
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
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                comment.username,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Text(
              comment.createdAt,
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
              InkWell(
                onTap: () => onReply(comment.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '답글',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '모든 답글',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

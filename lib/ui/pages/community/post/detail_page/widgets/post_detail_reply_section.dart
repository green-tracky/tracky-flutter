import 'package:flutter/material.dart';
import 'post_detail_reply.dart';
import 'post_detail_reply_comment_item.dart';

class ReplySection extends StatefulWidget {
  final List<Comment> initialComments;

  const ReplySection({super.key, required this.initialComments});

  @override
  State<ReplySection> createState() => _ReplySectionState();
}

class _ReplySectionState extends State<ReplySection> {
  final String currentUser = 'ssar';
  late List<Comment> allComments;

  List<Comment> comments = [];
  int page = 0;
  final int pageSize = 5;
  bool hasMore = true;

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    allComments = List.from(widget.initialComments);
    loadInitialReplies();
  }

  void loadInitialReplies() {
    comments = allComments.take(pageSize).toList();
    page = 1;
    hasMore = allComments.length > comments.length;
    setState(() {});
  }

  void loadMoreReplies() {
    final start = page * pageSize;
    final end = start + pageSize;

    if (start >= allComments.length) {
      hasMore = false;
      return;
    }

    final more = allComments.sublist(
      start,
      end > allComments.length ? allComments.length : end,
    );
    comments.addAll(more);
    page++;
    hasMore = comments.length < allComments.length;
    setState(() {});
  }

  void replyToComment(Comment comment) {
    setState(() {
      for (var c in comments) {
        c.isReplying = false;
        for (var r in c.replies) {
          r.isReplying = false;
        }
      }
      comment.isReplying = true;
    });
  }

  void cancelReply(Comment comment) {
    setState(() {
      comment.isReplying = false;
    });
  }

  void sendReply(Comment parent, String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      parent.replies.add(
        Comment(
          author: currentUser,
          content: text.trim(),
          createdAt: '2025.06.30 17:00',
        ),
      );
      parent.isReplying = false;
      parent.isRepliesExpanded = true;
    });
  }

  void sendMainComment(String text) {
    if (text.trim().isEmpty) return;
    FocusScope.of(context).unfocus();

    setState(() {
      comments.insert(
        0,
        Comment(
          author: currentUser,
          content: text.trim(),
          createdAt: '2025.06.30 17:00',
        ),
      );
    });
    controller.clear();
  }

  void deleteComment(Comment comment) {
    setState(() {
      if (comments.contains(comment)) {
        comments.remove(comment);
      } else {
        for (var c in comments) {
          c.replies.remove(comment);
        }
      }
    });
  }

  void editComment(Comment comment, String newText) {
    setState(() {
      comment.content = newText;
    });
  }

  void toggleReplies(Comment comment) {
    setState(() {
      comment.isRepliesExpanded = !comment.isRepliesExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ...comments.map(
              (comment) => commentItem(
                context,
                comment,
                onToggleReplies: () => toggleReplies(comment),
                onDelete: deleteComment,
                onReply: replyToComment,
                onCancelReply: cancelReply,
                onSendReply: sendReply,
                onEdit: editComment,
                currentUser: currentUser,
              ),
            ),
            if (hasMore)
              Padding(
                padding: const EdgeInsets.only(bottom: 12), // 하단 여백
                child: Center(
                  child: TextButton(
                    onPressed: loadMoreReplies,
                    child: const Text(
                      '댓글 더보기',
                      style: TextStyle(color: Color(0xFF021F59)),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 60),
          ],
        ),
        if (!comments.any((c) => c.isReplying))
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAEB),
                border: const Border(
                  top: BorderSide(
                    color: Colors.grey, // ✅ 선 색상
                    width: 0.5, // ✅ 선 두께
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: '댓글을 입력하세요...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: sendMainComment,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF021F59)),
                    onPressed: () => sendMainComment(controller.text),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

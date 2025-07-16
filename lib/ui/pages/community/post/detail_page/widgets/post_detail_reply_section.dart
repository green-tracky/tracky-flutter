import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
import 'post_detail_reply.dart';
import 'post_detail_reply_comment_item.dart';

class ReplySection extends StatefulWidget {
  final List<Comment> initialComments;
  final Function(int)? onCommentCountChanged;
  final Function(String)? onReplyStart;
  final Function()? onReplyEnd;

  const ReplySection({
    super.key,
    required this.initialComments,
    this.onCommentCountChanged,
    this.onReplyStart,
    this.onReplyEnd,
  });

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
    // 기존 댓글 순서를 최신순으로 정렬
    allComments = List.from(widget.initialComments)..sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
    widget.onReplyStart?.call(comment.author);
  }

  void cancelReply(Comment comment) {
    setState(() {
      comment.isReplying = false;
    });
    widget.onReplyEnd?.call();
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
      allComments.insert(0, comments.first);
    });
    widget.onCommentCountChanged?.call(comments.length);
    controller.clear();
  }

  void deleteComment(Comment comment) {
    setState(() {
      comments.remove(comment);
      allComments.remove(comment);
    });
    widget.onCommentCountChanged?.call(comments.length);
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
                    child: Text(
                      '댓글 더보기',
                      style: styleWithColor(
                        AppTextStyles.content,
                        AppColors.trackyIndigo,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'post_detail_reply.dart';

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

  Comment? replyingTo;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    allComments = List.from(widget.initialComments);
    loadInitialReplies();
  }

  void loadInitialReplies() {
    final end = pageSize;
    comments = allComments.sublist(0, end > allComments.length ? allComments.length : end);
    page = 1;
    hasMore = comments.length < allComments.length;
    setState(() {});
  }

  void loadMoreReplies() {
    final start = page * pageSize;
    final end = start + pageSize;

    if (start >= allComments.length) {
      hasMore = false;
      return;
    }

    final newItems = allComments.sublist(start, end > allComments.length ? allComments.length : end);
    comments.addAll(newItems);
    page++;
    hasMore = comments.length < allComments.length;
    setState(() {});
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

  void handleSend() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    FocusScope.of(context).unfocus();

    if (replyingTo != null) {
      setState(() {
        replyingTo!.replies.add(
          Comment(author: currentUser, content: text, createdAt: '25.06.30 17:00'),
        );
      });
    } else {
      setState(() {
        comments.insert(0, Comment(author: currentUser, content: text, createdAt: '25.06.30 17:00'));
      });
    }

    controller.clear();
    replyingTo = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...comments.map(
          (comment) => commentItem(
            context,
            comment,
            onToggleReplies: () => toggleReplies(comment),
            onDelete: deleteComment,
            onReply: (c) {
              setState(() {
                replyingTo = c;
              });
            },
            onEdit: editComment,
            currentUser: currentUser,
          ),
        ),
        if (hasMore)
          TextButton(
            onPressed: loadMoreReplies,
            child: const Text('댓글 더보기', style: TextStyle(color: Color(0xFF021F59))),
          ),
        const Divider(height: 1, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: replyingTo == null ? '댓글을 입력하세요...' : '${replyingTo!.author}에게 답글 달기...',
                    border: InputBorder.none,
                    suffixIcon: replyingTo != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                replyingTo = null;
                                controller.clear();
                              });
                            },
                            child: const Icon(Icons.close, color: Colors.grey),
                          )
                        : null,
                  ),
                  onSubmitted: (_) => handleSend(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF021F59)),
                onPressed: handleSend,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

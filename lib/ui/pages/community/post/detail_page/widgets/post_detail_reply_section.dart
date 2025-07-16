import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply_vm.dart';

class ReplySection extends StatelessWidget {
  final List<CommentViewModel> comments;
  final Function(String content, {int? parentId}) onAddComment;
  final Function(int commentId) onDeleteComment;

  const ReplySection({
    super.key,
    required this.comments,
    required this.onAddComment,
    required this.onDeleteComment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: comments.map((commentVM) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(commentVM.comment.username),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(commentVM.comment.content),
                  if (commentVM.isReplying)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            onAddComment(value.trim(), parentId: commentVM.comment.id);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: '${commentVM.comment.username}에게 답글 달기...',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              // 답글 입력 취소 처리
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'reply') {
                    // 답글 입력 상태 토글 처리
                  } else if (value == 'delete') {
                    onDeleteComment(commentVM.comment.id);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'reply', child: Text('답글')),
                  const PopupMenuItem(value: 'delete', child: Text('삭제')),
                ],
              ),
            ),
            if (commentVM.isRepliesExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: commentVM.comment.children.map((child) {
                    return ListTile(
                      title: Text(child.username),
                      subtitle: Text(child.content),
                    );
                  }).toList(),
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}

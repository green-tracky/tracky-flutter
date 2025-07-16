import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply_section.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply_vm.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_vm.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_map_view.dart';
import 'package:tracky_flutter/ui/pages/community/post/update_page/post_update_page.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  ConsumerState<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postDetailAsync = ref.watch(postDetailProvider(widget.postId));
    final replyAsync = ref.watch(postDetailReplyProvider(widget.postId));

    return postDetailAsync.when(
      data: (state) {
        return Scaffold(
          backgroundColor: AppColors.trackyBGreen,
          appBar: AppBar(
            backgroundColor: AppColors.trackyBGreen,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.trackyIndigo,
                size: Gap.lGap,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              '커뮤니티',
              style: AppTextStyles.appBarTitle,
            ),
            centerTitle: true,
            actions: [
              if (state.isOwner)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.trackyIndigo,
                  ),
                  color: Colors.white,
                  onSelected: (value) async {
                    if (value == 'edit') {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostUpdatePage(
                            initialContent: state.content,
                            selectedRunning: state.runRecord.title,
                          ),
                        ),
                      );
                      if (result != null) {
                        ref.invalidate(postDetailProvider(widget.postId));
                      }
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text(
                              '삭제하시겠습니까?',
                              style: styleWithColor(
                                AppTextStyles.semiTitle,
                                AppColors.trackyIndigo,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '취소',
                                  style: styleWithColor(
                                    AppTextStyles.content,
                                    Colors.grey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context, widget.postId);
                                },
                                child: Text(
                                  '삭제',
                                  style: styleWithColor(
                                    AppTextStyles.content,
                                    AppColors.trackyCancelRed,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '수정',
                            style: styleWithColor(
                              AppTextStyles.content,
                              AppColors.trackyIndigo,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: AppColors.trackyIndigo,
                            size: Gap.lGap,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '삭제',
                            style: styleWithColor(
                              AppTextStyles.content,
                              AppColors.trackyCancelRed,
                            ),
                          ),
                          Icon(
                            Icons.delete_outline,
                            color: AppColors.trackyCancelRed,
                            size: Gap.lGap,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const Divider(color: Colors.grey, thickness: 0.5, height: 0),
                    const SizedBox(height: 12),
                    Row(
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
                            state.user.username,
                            style: AppTextStyles.semiTitle,
                          ),
                        ),
                        Text(
                          state.createdAt,
                          style: styleWithColor(
                            AppTextStyles.plain,
                            Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.content,
                      style: AppTextStyles.content,
                    ),
                    const SizedBox(height: 12),
                    Stack(
                      children: [
                        PostMapView(paths: state.runRecord.segments.map((e) => e.coordinates).toList()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.comment_outlined, size: Gap.lGap),
                        const SizedBox(width: 4),
                        Text('${state.commentCount}'),
                        const SizedBox(width: 16),
                        Icon(
                          state.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: state.isLiked ? Colors.red : Colors.black,
                          size: Gap.lGap,
                        ),
                        Text('${state.likeCount}'),
                      ],
                    ),
                    const Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 12),
                    replyAsync.when(
                      data: (comments) => ReplySection(
                        comments: comments,
                        onAddComment: (content, {parentId}) {
                          ref
                              .read(postDetailReplyProvider(widget.postId).notifier)
                              .addComment(content, parentId: parentId);
                        },
                        onDeleteComment: (commentId) {
                          ref.read(postDetailReplyProvider(widget.postId).notifier).deleteComment(commentId);
                        },
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text("댓글 불러오기 실패: $e"),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.trackyBGreen,
                  border: const Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: '댓글을 입력하세요...',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            ref.read(postDetailReplyProvider(widget.postId).notifier).addComment(value.trim());
                            _commentController.clear();
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: AppColors.trackyIndigo,
                        size: Gap.lGap,
                      ),
                      onPressed: () {
                        if (_commentController.text.trim().isNotEmpty) {
                          ref
                              .read(postDetailReplyProvider(widget.postId).notifier)
                              .addComment(_commentController.text.trim());
                          _commentController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text("에러 발생: $error")),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply_repository.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_vm.dart';

final postDetailReplyProvider = AsyncNotifierProvider.family<PostDetailReplyVM, List<CommentViewModel>, int>(
  PostDetailReplyVM.new,
);

class PostDetailReplyVM extends FamilyAsyncNotifier<List<CommentViewModel>, int> {
  late int postId;
  late final PostDetailReplyRepository _repo;

  @override
  Future<List<CommentViewModel>> build(int argPostId) async {
    postId = argPostId;
    _repo = PostDetailReplyRepository();

    final List<CommentModel> comments = await _repo.fetchComments(postId);
    final List<CommentViewModel> commentViewModels = comments
        .map<CommentViewModel>((e) => CommentViewModel(comment: e))
        .toList();

    // state = AsyncData(commentViewModels); << 이 줄 삭제!
    return commentViewModels;
  }

  Future<void> addComment(String content, {int? parentId}) async {
    final newComment = await _repo.postComment(postId, content, parentId: parentId);
    final List<CommentViewModel> comments = [...(state.value ?? [])];

    if (parentId == null) {
      comments.insert(0, CommentViewModel(comment: newComment));
    } else {
      final index = comments.indexWhere((element) => element.comment.id == parentId);
      if (index != -1) {
        final parent = comments[index];
        final updatedChildren = [newComment, ...parent.comment.children];
        comments[index] = parent
            .copyWith(
              isRepliesExpanded: parent.isRepliesExpanded,
              isReplying: parent.isReplying,
              repliesPage: parent.repliesPage,
            )
            .copyWith(
              comment: parent.comment.copyWith(children: updatedChildren),
            );
      }
    }

    state = AsyncData<List<CommentViewModel>>(comments);
  }

  Future<void> deleteComment(int commentId) async {
    await _repo.deleteComment(postId, commentId);
    final List<CommentViewModel> comments = (state.value ?? []).where((c) => c.comment.id != commentId).toList();
    state = AsyncData<List<CommentViewModel>>(comments);
  }
}

class CommentViewModel {
  final CommentModel comment;
  final bool isReplying;
  final bool isRepliesExpanded;
  final int repliesPage;

  CommentViewModel({
    required this.comment,
    this.isReplying = false,
    this.isRepliesExpanded = false,
    this.repliesPage = 1,
  });

  CommentViewModel copyWith({
    CommentModel? comment,
    bool? isReplying,
    bool? isRepliesExpanded,
    int? repliesPage,
  }) {
    return CommentViewModel(
      comment: comment ?? this.comment,
      isReplying: isReplying ?? this.isReplying,
      isRepliesExpanded: isRepliesExpanded ?? this.isRepliesExpanded,
      repliesPage: repliesPage ?? this.repliesPage,
    );
  }
}

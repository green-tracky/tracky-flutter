import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply_repository.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply.dart';

final postDetailReplyProvider = AsyncNotifierProvider.family<PostDetailReplyVM, List<Comment>, int>(
  PostDetailReplyVM.new,
);

class PostDetailReplyVM extends AsyncNotifier<List<Comment>> {
  late final int postId;
  final _repo = PostDetailReplyRepository();

  @override
  Future<List<Comment>> build(int argPostId) async {
    postId = argPostId;
    return await _repo.fetchComments(postId);
  }

  Future<void> addComment(String content, {int? parentId}) async {
    final newComment = await _repo.postComment(postId, content, parentId: parentId);

    state = AsyncData([
      newComment,
      ...state.value ?? [],
    ]);
  }
}

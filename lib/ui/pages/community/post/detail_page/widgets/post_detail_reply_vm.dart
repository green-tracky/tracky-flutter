import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply_repository.dart';

final postDetailReplyProvider = AsyncNotifierProvider.family<PostDetailReplyVM, List<CommentModel>, int>(
  PostDetailReplyVM.new,
);

class PostDetailReplyVM extends AsyncNotifier<List<CommentModel>> {
  late final int postId;
  final _repo = PostDetailReplyRepository();

  @override
  Future<List<CommentModel>> build(int argPostId) async {
    postId = argPostId;
    final comments = await _repo.fetchComments(postId);
    return comments;
  }

  Future<void> addComment(String content, {int? parentId}) async {
    final newComment = await _repo.postComment(postId, content, parentId: parentId);
    state = AsyncData([
      newComment,
      ...(state.value ?? []),
    ]);
  }

  Future<void> deleteComment(int commentId) async {
    await _repo.deleteComment(postId, commentId);
    state = AsyncData([
      ...(state.value ?? []).where((c) => c.id != commentId),
    ]);
  }
}

class CommentViewModel {
  final CommentModel comment;
  bool isReplying;
  bool isRepliesExpanded;

  CommentViewModel({
    required this.comment,
    this.isReplying = false,
    this.isRepliesExpanded = false,
  });

  factory CommentViewModel.fromMap(Map<String, dynamic> map) {
    return CommentViewModel(
      comment: CommentModel.fromMap(map),
    );
  }
}

class CommentModel {
  final int id;
  final int postId;
  final int userId;
  final String username;
  String content;
  final int? parentId;
  final String createdAt;
  final String updatedAt;
  List<CommentModel> children;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.content,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.children,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? 0,
      postId: map['postId'] ?? 0,
      userId: map['userId'] ?? 0,
      username: map['username'] ?? '',
      content: map['content'] ?? '',
      parentId: map['parentId'],
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      children: (map['children'] as List<dynamic>? ?? []).map((child) => CommentModel.fromMap(child)).toList(),
    );
  }

  static CommentModel empty() {
    return CommentModel(
      id: 0,
      postId: 0,
      userId: 0,
      username: '',
      content: '',
      parentId: null,
      createdAt: '',
      updatedAt: '',
      children: [],
    );
  }
}

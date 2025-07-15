import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'post_save_repository.dart';
import 'post_save_model.dart';

// ✅ Provider 정의
final postSaveProvider = AsyncNotifierProviderFamily<PostSaveVM, PostSaveState, int?>(
  PostSaveVM.new,
);

// ✅ State 정의
class PostSaveState {
  final String content;
  final int? runRecordId;
  final List<int> pictureIds;

  PostSaveState({
    required this.content,
    required this.runRecordId,
    required this.pictureIds,
  });

  PostSaveState copyWith({
    String? content,
    int? runRecordId,
    List<int>? pictureIds,
  }) {
    return PostSaveState(
      content: content ?? this.content,
      runRecordId: runRecordId ?? this.runRecordId,
      pictureIds: pictureIds ?? this.pictureIds,
    );
  }
}

// ✅ ViewModel 정의
class PostSaveVM extends FamilyAsyncNotifier<PostSaveState, int?> {
  final _repo = PostSaveRepository();

  @override
  Future<PostSaveState> build(int? postId) async {
    if (postId == null) {
      return PostSaveState(content: '', runRecordId: null, pictureIds: []);
    } else {
      final post = await _repo.fetchPostDetail(postId);
      return PostSaveState(
        content: post.content,
        runRecordId: post.runRecordId,
        pictureIds: post.pictureIds,
      );
    }
  }

  void updateContent(String content) {
    state = AsyncData(state.value!.copyWith(content: content));
  }

  void updateRunRecordId(int id) {
    state = AsyncData(state.value!.copyWith(runRecordId: id));
  }

  void updatePictureIds(List<int> ids) {
    state = AsyncData(state.value!.copyWith(pictureIds: ids));
  }

  Future<void> savePost() async {
    final current = state.value!;
    if (current.runRecordId == null || current.content.isEmpty) {
      throw Exception('필수값 누락');
    }
    await _repo.savePost(current);
  }
}

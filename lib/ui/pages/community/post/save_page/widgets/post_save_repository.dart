import 'dart:async';
import 'post_save_model.dart';
import 'post_save_vm.dart';

class PostSaveRepository {
  Future<PostSaveModel> fetchPostDetail(int postId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return PostSaveModel(
      id: postId,
      content: '기존 내용입니다',
      runRecordId: 10,
      pictureIds: [1, 2],
    );
  }

  Future<void> savePost(PostSaveState state) async {
    await Future.delayed(const Duration(milliseconds: 500));

    print("저장 완료: ${state.content}, RunRecordId: ${state.runRecordId}, PictureIds: ${state.pictureIds}");
  }
}

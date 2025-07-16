import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/dio.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_model.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_repository.dart';

// Provider 정의
final postListProvider = AsyncNotifierProvider<PostListVM, List<PostListModel>>(
  PostListVM.new,
);

// ViewModel 정의
class PostListVM extends AsyncNotifier<List<PostListModel>> {
  late final PostListRepository _repo;

  @override
  Future<List<PostListModel>> build() async {
    const token = '여기에_토큰_입력';
    dio.options.headers['Authorization'] = 'Bearer $token'; // 기존 dio 인스턴스 헤더 설정

    _repo = PostListRepository(dio: dio, useDummyData: true); // true면 더미, false면 서버

    try {
      final result = await _repo.fetchPostList();
      print("서버 응답: $result");
      return result;
    } catch (e, s) {
      print("서버 통신 에러: $e");
      print("스택: $s");
      rethrow;
    }

    // final result = await _repo.fetchPostList();
    // return result;
  }

  void deletePostById(int id) {
    state = AsyncData(
      state.value?.where((post) => post.id != id).toList() ?? [],
    );
  }
}

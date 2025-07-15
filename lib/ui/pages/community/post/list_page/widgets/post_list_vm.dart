import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_model.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_repository.dart';

// Provider 정의
final postListProvider = AsyncNotifierProvider<PostListVM, List<PostListModel>>(
  PostListVM.new,
);

// ViewModel 정의
class PostListVM extends AsyncNotifier<List<PostListModel>> {
  final _repo = PostListRepository();

  @override
  Future<List<PostListModel>> build() async {
    final result = await _repo.fetchPostList();
    return result;
  }

  void deletePostById(int id) {
    state = AsyncData(
      state.value?.where((post) => post.id != id).toList() ?? [],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_model.dart';

// Provider 정의
final postListProvider = AsyncNotifierProvider<PostListVM, List<PostListModel>>(
  PostListVM.new,
);

// ViewModel 정의
class PostListVM extends AsyncNotifier<List<PostListModel>> {
  @override
  Future<List<PostListModel>> build() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 더미 딜레이

    return [
      PostListModel(
        id: 1,
        author: "ssar",
        content: "오늘도 힘차게 달려요!!",
        createdAt: "2025.06.18 17:00",
        likeCount: 3,
        commentCount: 3,
        isLiked: false,
        imageUrls: [
          'assets/images/kb_bank.png',
          'assets/images/kyochon_chicken.png',
          'assets/images/Screenshot_1.png',
          'assets/images/Screenshot_2.png',
        ],
      ),
      PostListModel(
        id: 2,
        author: "cos",
        content: "오늘 날씨가 좋아서 러닝하기 좋아요",
        createdAt: "2025.06.17 15:00",
        likeCount: 2,
        commentCount: 2,
        isLiked: true,
        imageUrls: [
          'assets/images/kb_bank.png',
          'assets/images/kyochon_chicken.png',
          'assets/images/Screenshot_1.png',
          'assets/images/Screenshot_2.png',
        ],
      ),
      // 나머지도 동일하게...
    ];
  }

  void deletePostById(int id) {
    state = AsyncData(
      state.value?.where((post) => post.id != id).toList() ?? [],
    );
  }
}

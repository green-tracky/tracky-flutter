import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/post_detail_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_appbar.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/widgets/post_list_vm.dart';
import 'package:tracky_flutter/ui/pages/community/post/save_page/post_save_page.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';
import 'widgets/post_card.dart';

class PostListPage extends ConsumerWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postListAsync = ref.watch(postListProvider);

    return Scaffold(
      appBar: PostListAppBar(),
      endDrawer: const CommunityDrawer(),
      backgroundColor: AppColors.trackyBGreen,
      body: postListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("에러: $err")),
        data: (posts) => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "커뮤니티",
                  style: styleWithColor(
                    AppTextStyles.pageTitle,
                    AppColors.trackyIndigo,
                  ),
                ),
              );
            }

            final post = posts[index - 1];

            return PostCard(
              postId: post.id,
              username: post.author,
              content: post.content,
              createdAt: post.createdAt,
              likeCount: post.likeCount,
              commentCount: post.commentCount,
              isLiked: post.isLiked,
              imageUrl: post.imageUrls.isNotEmpty ? post.imageUrls.first : 'assets/images/mountain.jpg',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostDetailPage(
                      postId: post.id,
                    ),
                  ),
                );

                if (result != null) {
                  ref.read(postListProvider.notifier).deletePostById(result);
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 66,
        height: 66,
        child: FloatingActionButton(
          backgroundColor: AppColors.trackyNeon,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostSavePage()),
            );

            if (result == true) {
              ref.invalidate(postListProvider); // ✅ 갱신 포인트
            }
          },
          child: const Icon(
            Icons.edit,
            color: AppColors.trackyIndigo,
            size: Gap.xxlGap,
          ), // 글쓰기 아이콘
        ),
      ),
    );
  }
}

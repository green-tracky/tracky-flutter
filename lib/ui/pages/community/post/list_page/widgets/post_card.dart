import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply.dart';

final List<Comment> dummyComments = List.generate(
  5,
  (i) => Comment(
    id: i + 1,
    postId: 1,
    userId: i % 2 == 0 ? 2 : 3,
    username: i % 2 == 0 ? 'cos' : 'user$i',
    content: '댓글 내용 $i',
    parentId: null,
    createdAt: '2025-07-09 11:33:11',
    children: generateReplies(i),
  ),
);

List<Comment> generateReplies(int parentId) {
  return List.generate(
    2,
    (index) => Comment(
      id: index + 100,
      postId: 1,
      userId: index % 2 == 0 ? 1 : 3,
      username: index % 2 == 0 ? 'ssar' : 'love',
      content: '대댓글 $index',
      parentId: parentId,
      createdAt: '2025-07-09 11:33:11',
      children: [],
    ),
  );
}

class PostCard extends StatefulWidget {
  final int postId;
  final String username;
  final String content;
  final String createdAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final String imageUrl;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.postId,
    required this.username,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.imageUrl,
    this.onTap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  /// ✅ 썸네일 이미지 고정
  Widget buildThumbnail() {
    return Image.asset(
      widget.imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          child: Center(child: Text('썸네일 없음')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: AppColors.trackyBGreen,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: AppColors.trackyIndigo,
        highlightColor: Colors.transparent,
        onTap: widget.onTap,

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 작성자 + 날짜
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.trackyIndigo,
                    child: Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.createdAt,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// 본문 내용
              Text(
                widget.content,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),

              /// 이미지 or 지도 영역
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    color: Colors.white,
                    child: buildThumbnail(),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const Divider(
                height: 1,
                thickness: 0.25,
                color: Colors.grey,
              ),
              const SizedBox(height: 12),

              /// 댓글 수 / 좋아요
              Row(
                children: [
                  const Icon(Icons.comment_outlined, size: 20),
                  const SizedBox(width: 4),
                  Text('${widget.commentCount}'),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text('$likeCount'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/post_detail_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/detail_page/widgets/post_detail_reply.dart';

final List<Comment> dummyComments = List.generate(
  11,
  (i) => Comment(
    author: i % 2 == 0 ? 'cos' : 'user$i',
    content: '댓글 내용 $i',
    createdAt: '2025.06.29 10:${i.toString().padLeft(2, '0')}',
    replies: generateReplies(),
  ),
);

class PostCard extends StatefulWidget {
  final String author;
  final String content;
  final String createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final List<String> imageUrls;
  final String thumbnailImage;

  const PostCard({
    super.key,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.imageUrls,
    required this.thumbnailImage,
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
    likeCount = widget.likesCount;
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
      widget.thumbnailImage,
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
      color: const Color(0xFFF9FAEB),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: const Color(0x14021F59),
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailPage(
                author: widget.author,
                content: widget.content,
                createdAt: widget.createdAt,
                imageUrls: widget.imageUrls,
                likeCount: likeCount,
                commentCount: widget.commentsCount,
                commentList: dummyComments,
              ),
            ),
          );
        },

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
                    backgroundColor: Color(0xFF021F59),
                    child: Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.author,
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
                  Text('${widget.commentsCount}'),
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

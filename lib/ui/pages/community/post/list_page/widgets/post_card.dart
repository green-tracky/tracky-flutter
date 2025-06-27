import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String author;
  final String content;
  final String createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final String? imageUrl;

  const PostCard({
    super.key,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    this.imageUrl,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      color: const Color(0xFFF9FAEB),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 작성자 + 프로필 + 날짜
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFF021F59),
                  child: Icon(Icons.person, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 8),
                // 이름 길이 제한
                Expanded(
                  child: Text(
                    widget.author,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // 작성 시간
                Text(
                  widget.createdAt,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 본문 내용
            Text(
              widget.content,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 12),

            // 이미지 or Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 4 / 3, // 가로 : 세로 = 4 : 3
                child: Container(
                  color: Colors.white,
                  child: widget.imageUrl != null
                      ? Image.network(
                          widget.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          'https://cdn.pixabay.com/photo/2016/02/07/19/50/mountaineer-1185474_1280.jpg',
                          fit: BoxFit.cover,
                        ),
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

            // 댓글 수 / 좋아요
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
    );
  }
}

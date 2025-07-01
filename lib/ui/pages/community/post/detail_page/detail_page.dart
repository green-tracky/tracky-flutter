import 'package:flutter/material.dart';
import 'widgets/post_detail_reply.dart';
import 'widgets/post_detail_reply_section.dart';

class PostDetailPage extends StatelessWidget {
  final String author;
  final String content;
  final String createdAt;
  final List<String> imageUrls;
  final int likeCount;
  final int commentCount;
  final List<Comment> commentList;

  const PostDetailPage({
    super.key,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.imageUrls,
    required this.likeCount,
    required this.commentCount,
    required this.commentList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF021F59)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '커뮤니티',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF021F59),
            ),
            color: Colors.white,
            onSelected: (value) {
              if (value == 'edit') {
                print('수정 클릭됨');
              } else if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text(
                        '삭제하시겠습니까?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF021F59),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '취소',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('게시글이 삭제되었습니다.'),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            print('삭제 완료');
                          },
                          child: const Text(
                            '삭제',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '수정',
                      style: TextStyle(
                        color: Color(0xFF021F59),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.edit, color: Color(0xFF021F59), size: 18),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '삭제',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.delete_outline, color: Colors.red, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Divider(color: Colors.grey, thickness: 0.5, height: 0),
          const SizedBox(height: 12),

          /// 작성자 + 날짜
          Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFF021F59),
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  author,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                createdAt,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 본문 내용
          Text(content, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),

          /// 지도 영역 + 사진보기 버튼
          AspectRatio(
            aspectRatio: 9 / 16,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      '지도 영역',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                /// 사진보기 버튼
                Positioned(
                  right: 12,
                  top: 12,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD0F252),
                      foregroundColor: const Color(0xFF021F59),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 1,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.black.withOpacity(0.9),
                            insetPadding: const EdgeInsets.all(10),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        imageUrls[index],
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      '사진보기',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// 댓글 수 / 좋아요
          Row(
            children: [
              const Icon(Icons.comment_outlined, size: 20),
              const SizedBox(width: 4),
              Text('$commentCount'),
              const SizedBox(width: 16),
              const Icon(Icons.favorite_border, size: 20),
              const SizedBox(width: 4),
              Text('$likeCount'),
            ],
          ),

          const SizedBox(height: 12),

          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 12),

          /// 댓글 섹션
          ReplySection(initialComments: commentList),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

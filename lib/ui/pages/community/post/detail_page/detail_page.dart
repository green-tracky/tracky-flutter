import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final String author;
  final String content;
  final String createdAt;
  final String? imageUrl;

  const PostDetailPage({
    super.key,
    required this.author,
    required this.content,
    required this.createdAt,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // 원하는 아이콘으로 변경
          color: Color(0xFF021F59),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 기능 유지
          },
        ),
        title: const Text(
          '커뮤니티',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
        ),
        centerTitle: true,
        // 햄버거 메뉴
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 0,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 작성자 정보
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xFF021F59),
                        child: Icon(Icons.person, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 8),
                      // 작성자 이름
                      Expanded(
                        child: Text(
                          author,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 작성 시간
                      Text(
                        createdAt,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 본문
                  Text(
                    content,
                    style: const TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 12),

                  // 이미지
                  if (imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
        title: const Text(
          '커뮤니티',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(author, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(createdAt, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl!),
              ),
          ],
        ),
      ),
    );
  }
}

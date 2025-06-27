import 'package:flutter/material.dart';

class PostCreatePage extends StatelessWidget {
  const PostCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("글쓰기")),
      body: const Center(child: Text("글쓰기 화면")),
    );
  }
}

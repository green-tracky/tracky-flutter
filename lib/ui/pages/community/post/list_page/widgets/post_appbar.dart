import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/post/create_page/post_create_page.dart';

class PostListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostListAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 기본 높이

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF9FAEB),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text(
        '게시글',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF021F59)),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO 검색창 만들기
          },
        ),
        IconButton(
          icon: const Icon(Icons.add_box_outlined),
          onPressed: () {
            // TODO: 글쓰기
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostCreatePage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }
}

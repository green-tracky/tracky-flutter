import 'package:flutter/material.dart';

class PostListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostListAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAEB),
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            // 프로필 버튼 클릭 이벤트
            Navigator.pushNamed(context, '/profile');
          },
          child: const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF021F59),
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF021F59)),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // TODO 검색창 만들기
          },
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // 메뉴 기능
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }
}

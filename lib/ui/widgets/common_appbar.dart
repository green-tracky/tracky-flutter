import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CommonAppBar({Key? key})
    : preferredSize = const Size.fromHeight(90),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFF9FAEB),
      elevation: 0,
      toolbarHeight: 90,
      automaticallyImplyLeading: false,

      // 왼쪽 아이콘 (프로필 동그라미)
      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {
            print("클릭됨");
          },
          child: CircleAvatar(radius: 21, backgroundColor: Color(0xFFE0E0E0)),
        ),
      ),

      // 오른쪽 햄버거 메뉴
      actions: [
        IconButton(
          icon: Icon(Icons.menu, color: Color(0xFF021F59)),
          onPressed: () {},
        ),
        SizedBox(width: 8),
      ],
    );
  }
}

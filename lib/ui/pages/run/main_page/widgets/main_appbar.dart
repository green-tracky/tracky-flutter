import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const MainAppbar({Key? key}) : preferredSize = const Size.fromHeight(90), super(key: key);

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
        child: SizedBox(
          width: 42,
          height: 42,
          child: Material(
            color: Colors.transparent,
            shape: CircleBorder(), // 원형 클릭 영역
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: CircleAvatar(
                radius: 21,
                backgroundColor: Color(0xFF021F59),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

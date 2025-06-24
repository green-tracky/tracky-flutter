import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonBottomNav extends StatelessWidget {
  const CommonBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      selectedItemColor: Color(0xFF021F59),
      unselectedItemColor: Colors.black45,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFF9FAEB),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: '플랜',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.directions_run), label: '러닝'),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: '커뮤니티',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard_outlined),
          label: '활동',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/list_page.dart';
import 'package:tracky_flutter/ui/widgets/common_bottom_nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/running',
      routes: {
        '/plan': (context) => const DummyPage(title: '플랜 페이지'),
        '/running': (context) => const DummyPage(title: '러닝 페이지'),
        '/community': (context) => const DummyPage(title: '커뮤니티', child: ChallengeListPage()),
        '/post': (context) => const DummyPage(title: '게시글', child: PostListPage()),
        '/activity': (context) => const DummyPage(title: '활동', child: LeaderboardView()),
      },
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  final Widget? child;
  const DummyPage({super.key, required this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child ?? Center(child: Text('$title 내용')),
      bottomNavigationBar: CommonBottomNav(),
    );
  }
}

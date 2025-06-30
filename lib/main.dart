import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/list_page.dart';
import 'package:tracky_flutter/ui/widgets/common_bottom_nav.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/running',
      routes: {
        '/plan': (context) => const DummyPage(title: '플랜'),
        '/running': (context) => const DummyPage(title: '러닝'),
        '/community': (context) => const DummyPage(title: '커뮤니티', child: PostListPage()),
        '/challenge': (context) => const DummyPage(title: '챌린지', child: ChallengeListPage()),
        '/leaderboard': (context) => const DummyPage(title: '리더보드', child: LeaderboardView()),
        '/activity': (context) => const DummyPage(title: '활동'),
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

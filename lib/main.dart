import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/list_page.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/running_level_page.dart';
import 'package:tracky_flutter/ui/pages/auth/join/join_page.dart';
import 'package:tracky_flutter/ui/pages/auth/login/login_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/list_page.dart';
import 'package:tracky_flutter/ui/pages/friend/list_friend_page.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_editing_page/profile_editing_page.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_page.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/widgets/common_bottom_nav.dart';

import 'ui/pages/profile/widgets/setting_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/runninglist': (context) => DummyPage(title: '전체러닝', child: RunningListPage()),
        '/runninglevel': (context) => DummyPage(title: '러닝레벨', child: RunningLevelPage()),
        '/friend': (context) => const DummyPage(title: '친구', child: ListFriendPage()),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/update/profile': (context) => ProfileEditingPage(),
        '/login': (context) => const LoginPage(),
        '/join': (context) => const JoinPage(),
        '/plan': (context) => const DummyPage(title: '플랜'),
        '/running': (context) => const DummyPage(title: '러닝', child: RunMainPage()),
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

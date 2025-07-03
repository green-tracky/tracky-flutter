import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/list_page.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/running_badge_page.dart';
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
        '/runningbadge': (context) => RunningBadgePage(),
        '/runninglist': (context) => RunningListPage(),
        '/runninglevel': (context) => RunningLevelPage(),
        '/friends': (context) => ListFriendPage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/update/profile': (context) => ProfileEditingPage(),
        '/login': (context) => const LoginPage(),
        '/join': (context) => const JoinPage(),
        '/plan': (context) => const DummyPage(title: '플랜', currentIndex: 0),
        '/running': (context) => const DummyPage(title: '러닝', child: RunMainPage(), currentIndex: 1),
        '/community': (context) => const DummyPage(title: '커뮤니티', child: PostListPage(), currentIndex: 2),
        '/challenge': (context) => const DummyPage(title: '챌린지', child: ChallengeListPage(), currentIndex: 2),
        '/leaderboard': (context) => const DummyPage(title: '리더보드', child: LeaderboardView(), currentIndex: 2),
        '/activity': (context) => const DummyPage(title: '활동', currentIndex: 3),
      },
    );
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  final Widget? child;
  final int currentIndex;

  const DummyPage({
    super.key,
    required this.title,
    this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child ?? Center(child: Text('$title 내용')),
      bottomNavigationBar: CommonBottomNav(currentIndex: currentIndex),
    );
  }
}

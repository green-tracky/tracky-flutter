import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/list_page.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/running_badge_page.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/running_level_page.dart';
import 'package:tracky_flutter/ui/pages/auth/join/join_page.dart';
import 'package:tracky_flutter/ui/pages/auth/login/login_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/invite_page/invite_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/list_page.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/post_list_page.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_invite_page/friend_invite_page.dart';
import 'package:tracky_flutter/ui/pages/plan/plan_page.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_editing_page/profile_editing_page.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_page.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/widgets/common_bottom_nav.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ui/pages/profile/profile_message_page/profile_message_page.dart';
import 'ui/pages/profile/profile_setting_page/setting_page.dart';

// TODO: 1. Stack의 가장 위 context를 알고 있다.
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const kakaoAppKey = String.fromEnvironment(
  'KAKAO_NATIVE_APP_KEY',
  // 키 값 못 불러올 경우 디폴트 값
  defaultValue: '1414e098bb3e8e534da7a603c95c573e',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dotenv로 환경변수 파일 호출 : git에는 업로드가 되지 않으므로 만들어줘야 함
  // await dotenv.load(fileName: ".env");
  // runApp() 호출 전 Flutter SDK 초기화
  final keyHash = await KakaoSdk.origin;
  debugPrint("🔑 Key Hash: $keyHash");


  KakaoSdk.init(
    nativeAppKey:
        //dotenv.env["KAKAO_NATIVE_APP_KEY"]
        kakaoAppKey,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/invite': (context) => ChallengeInvitePage(),
        '/runningbadge': (context) => RunningBadgePage(),
        '/runninglist': (context) => RunningListPage(),
        '/runninglevel': (context) => RunningLevelPage(),
        '/friends': (context) => InviteFriendPage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/update/profile': (context) => ProfileEditingPage(),
        '/messages': (context) => const ProfileMessagePage(),
        '/login': (context) => const LoginPage(),
        '/join': (context) => const JoinPage(),
        '/plan': (context) => DummyPage(title: '플랜', child: PlanPage(), currentIndex: 0),
        '/running': (context) => const DummyPage(title: '러닝', child: RunMainPage(), currentIndex: 1),
        '/community': (context) => const DummyPage(
          title: '커뮤니티',
          child: PostListPage(),
          currentIndex: 2,
        ),
        // 챌린지, 리더보드는 Body를 교체하는 방식으로 수정해야 함
        '/challenge': (context) => const DummyPage(
          title: '챌린지',
          child: ChallengeListPage(),
          currentIndex: 2,
        ),
        '/leaderboard': (context) => const DummyPage(
          title: '리더보드',
          child: LeaderboardMainPage(),
          currentIndex: 2,
        ),
        '/activity': (context) => DummyPage(
          title: '활동',
          child: ActivityPage(),
          currentIndex: 3,
        ),
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

/* // lib/main.dart

import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/utils/fcm_service.dart';

import 'screens/friend_requests_screen.dart'; // 친구 요청 화면 파일
import 'services/fcm_service.dart'; // 모든 FCM 로직이 담긴 서비스 파일
// 1. 우리가 직접 만든 모듈들을 가져옵니다(import).
import 'services/firebase_options.dart'; // Firebase 자동 설정 파일

// 2. [핵심] 네비게이터 글로벌 키(GlobalKey) 생성
// 이 키는 앱 전체의 네비게이션 상태를 관리하는 만능 열쇠입니다.
// FcmService가 앱의 어느 곳에서든 화면을 이동시켜야 할 때 이 키를 사용합니다.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// 앱의 가장 첫 시작점인 main 함수입니다.
void main() async {
  // Flutter 엔진과 위젯이 상호작용할 수 있도록 보장해주는 필수 코드입니다.
  // main 함수 내에서 await 키워드를 사용하려면 반드시 최상단에 위치해야 합니다.
  WidgetsFlutterBinding.ensureInitialized();

  // 6. 모든 준비가 끝나면, 화면에 보여줄 앱 위젯을 실행합니다.
  runApp(const MyFcmApp());
}

/// 이 위젯이 우리 앱의 최상위 위젯입니다.
class MyFcmApp extends StatelessWidget {
  const MyFcmApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 앱의 기본적인 디자인, 테마, 화면 이동(라우팅) 규칙을 정의합니다.
    return MaterialApp(
      // 7. [핵심] MaterialApp에 네비게이터 키를 장착합니다.
      // 이제 이 키는 이 MaterialApp의 모든 화면 이동을 제어할 수 있게 됩니다.
      navigatorKey: navigatorKey,
      title: 'FCM 알림 테스트',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // 앱의 전체적인 테마 색상을 정의합니다.
        useMaterial3: true,
      ),
      // 8. 앱의 첫 화면(home)으로 HomeScreen 위젯을 지정합니다.
      home: const HomeScreen(),
      // 9. [핵심] 화면 이동 규칙(routes)을 정의합니다.
      // '/friend_requests' 라는 이름으로 화면을 이동하라는 명령이 오면,
      // FriendRequestsScreen() 위젯을 화면에 보여주라는 규칙입니다.
      routes: {'/friend_requests': (context) => const FriendRequestsScreen()},
    );
  }
}

/// 앱의 첫 화면을 구성하는 위젯입니다.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FCM 기능 테스트')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('아래 버튼을 누르면 친구 요청이 전송됩니다.', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            // 10. [핵심] FCM 기능을 테스트하기 위한 버튼
            ElevatedButton(
              onPressed: () {
                // 버튼을 누르면, FcmService의 sendTestFriendRequest() 메소드를 호출합니다.
                // 이 메소드는 서버로 친구 요청 API를 전송하는 역할을 합니다.
                // 실제 앱에서는 로그인 정보 등을 기반으로 한 인스턴스를 사용해야 하지만,
                // 지금은 테스트를 위해 간단히 새로 생성하여 호출합니다.
                // TODO : 알림 보내는 함수
                FcmService(navigatorKey: navigatorKey).sendTestFriendRequest();

                // 사용자에게 요청이 보내졌음을 간단히 알려줍니다.
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('서버로 친구 요청을 보냈습니다!'), duration: Duration(seconds: 2)));
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('친구 요청 보내기 (테스트)', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
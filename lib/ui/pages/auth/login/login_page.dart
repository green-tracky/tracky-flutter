import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/auth/login/widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_bg.png', // ← 실제 Nike 스타일 배경 이미지
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // 살짝 어두운 오버레이
          ),
          LoginBody(),
        ],
      ),
    );
  }
}



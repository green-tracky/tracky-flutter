import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/auth/join/join_complete_page/widgets/join_complete_body.dart';

class JoinCompletePage extends StatelessWidget {
  const JoinCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // 어두운 오버레이
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
              child: JoinCompleteBody(),
            ),
          ),
        ],
      ),
    );
  }
}







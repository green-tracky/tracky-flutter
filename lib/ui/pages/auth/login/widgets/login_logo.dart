import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 0.0,
          top: 0.0,
        ), // ← 좌측 상단에 더 가깝게
        child: Image.asset(
          'assets/images/tracky_logo_white.png', // RUN 로고
          height: 140, // ← 로고 크기 키움
          width: 140,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
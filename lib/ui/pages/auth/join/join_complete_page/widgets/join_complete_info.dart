import 'package:flutter/material.dart';

class JoinCompleteInfo extends StatelessWidget {
  const JoinCompleteInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "완료되었습니다!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Text(
          "사용자 정보 입력이 완료되었습니다.\nTracky와 함께 러닝을 시작하세요.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
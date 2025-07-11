import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class LeaderboardDescription extends StatelessWidget {
  const LeaderboardDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '친구가 많을 수록\n더 멀리 달릴 수 있습니다.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.6,
          ),
        ),
        Gap.m,
        Text(
          '달리기 친구들과 함께 리더보드를\n공유하고 비교하며 경쟁해보세요.\n서로를 위한 최고의 동기부여를 제공합니다.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

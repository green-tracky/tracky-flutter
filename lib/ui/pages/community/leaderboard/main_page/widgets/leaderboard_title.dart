import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class LeaderboardTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, bottom: 12), // Gap.s 대체
      child: Text(
        '리더보드',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.trackyIndigo,
        ),
      ),
    );
  }
}

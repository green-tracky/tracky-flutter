import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

Widget RankLeaderBoard() {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 14, top: 20),
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

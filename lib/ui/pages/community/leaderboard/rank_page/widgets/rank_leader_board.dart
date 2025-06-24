import 'package:flutter/material.dart';

Padding RankLeaderBoard() {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 14, top: 20),
    child: Text(
      '리더보드',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Color(0xFF021F59),
      ),
    ),
  );
}

import 'package:flutter/material.dart';

Widget RankText() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Text(
      '회원님과 친구의 거리 기록이 여기에 표시됩니다.',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),
    ),
  );
}

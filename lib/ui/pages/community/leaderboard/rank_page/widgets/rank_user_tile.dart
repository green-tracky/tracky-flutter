import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Leaderboard.dart';

Widget RankUserTile(RankUser user) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        print('프로필 클릭됨: ${user.name}');
        // TODO: Navigator.push(...)
      },
      child: Container(
        color: AppColors.trackyBGreen,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            // 순위 (너비 고정)
            SizedBox(
              width: 24,
              child: Text(
                '${user.rank}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.trackyIndigo,
                ),
              ),
            ),

            Gap.m, // 🔹 번호 ↔ 아이콘 사이
            // 프로필 아이콘
            // 아이콘 부분만 수정
            Padding(
              padding: EdgeInsets.only(right: 12), // 또는 6~8로 실험해볼 수 있음
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[400],
                child: Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),

            Gap.m, // 🔹 아이콘 ↔ 이름 사이
            // 이름
            Expanded(
              child: Text(
                user.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.trackyIndigo,
                ),
              ),
            ),

            // 거리
            Text(
              user.distance != null ? '${user.distance} km' : '--',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

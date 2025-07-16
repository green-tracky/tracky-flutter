import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/rank_vm.dart';

Widget RankUserTile(RankingUser user) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        print('프로필 클릭됨: ${user.username}');
        // TODO: Navigator.push(...), 상세 페이지 이동 등
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

            Gap.m,
            // 프로필 이미지 (네트워크)
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[400],
                backgroundImage: NetworkImage(user.profileUrl),
                child: user.profileUrl.isEmpty ? Icon(Icons.person, size: 20, color: Colors.white) : null,
              ),
            ),

            Gap.m,
            // 닉네임
            Expanded(
              child: Text(
                user.username,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.trackyIndigo,
                ),
              ),
            ),

            // 거리(km 변환, 0이면 --)
            Text(
              user.totalDistanceMeters > 0 ? '${(user.totalDistanceMeters / 1000).toStringAsFixed(1)} km' : '--',
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

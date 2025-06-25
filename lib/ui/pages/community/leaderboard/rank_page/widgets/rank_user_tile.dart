import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/model/Leaderboard.dart';

Material RankUserTile(RankUser user) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () {
        print('프로필 클릭됨: ${user.name}');
        // TODO: Navigator.push(...)
      },
      child: Container(
        color: Color(0xFFF9FAEB),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            Text(
              '${user.rank}',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF021F59),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 16),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[400],
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                user.name,
                style: TextStyle(
                  fontSize: 18,
                  // fontFamily: "Consolas",
                  color: Color(0xFF021F59),
                ),
              ),
            ),
            Text(
              user.distance != null ? '${user.distance} km' : '--',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    ),
  );
}

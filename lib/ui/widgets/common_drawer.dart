import 'package:flutter/material.dart';

class CommunityDrawer extends StatelessWidget {
  const CommunityDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 닫기 버튼과 인사말 Row
            Padding(
              padding: EdgeInsets.only(top: 50, left: 30, right: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SSAR 님,',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF021F59),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '오늘도 힘차게 달려봐요',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              leading: Text('🧑‍🤝‍🧑', style: TextStyle(fontSize: 20)),
              title: Text('커뮤니티', style: TextStyle(color: Color(0xFF021F59))),
              trailing: Icon(Icons.chevron_right, color: Color(0xFF021F59)),
              onTap: () {
                // TODO: 커뮤니티 이동
              },
            ),
            ListTile(
              leading: Text('🔥', style: TextStyle(fontSize: 20)),
              title: Text('챌린지', style: TextStyle(color: Color(0xFF021F59))),
              trailing: Icon(Icons.chevron_right, color: Color(0xFF021F59)),
              onTap: () {
                // TODO: 챌린지 이동
              },
            ),
            ListTile(
              leading: Text('🏆', style: TextStyle(fontSize: 20)),
              title: Text('리더보드', style: TextStyle(color: Color(0xFF021F59))),
              trailing: Icon(Icons.chevron_right, color: Color(0xFF021F59)),
              onTap: () {
                // TODO: 리더보드 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}

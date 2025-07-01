import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/add_friend_page.dart';

class InviteFriendPage extends StatelessWidget {
  const InviteFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          '친구 초대하기',
          style: TextStyle(
            color: Color(0xFF021F59), // 텍스트 색상
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              '친구 추가하여 초대하기',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF021F59),
              ),
            ),
            SizedBox(height: 40),

            // 검색 아이템
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.search, color: Colors.black),
                ),
                SizedBox(width: 18),
                Text(
                  '추가할 친구 찾기',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 35),

            // 초대 설명 아이템
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person_add_alt, color: Colors.black),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: Text(
                    '친구 요청이 수락되면 나의 챌린지로 \n친구를 초대할 수 있습니다.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFriendPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD0F252),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '친구 추가',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF021F59),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

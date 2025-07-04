import 'package:flutter/material.dart';

import 'list_friend_page.dart';

class DetailFriendPage extends StatelessWidget {
  final String name;
  final String email;
  final bool isFriend;

  const DetailFriendPage({
    super.key,
    required this.name,
    required this.email,
    this.isFriend = false,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('친구 삭제'),
        content: Text('$name님을(를) 친구에서 삭제하시겠습니까?'),
        actions: [
          TextButton(
            child: Text(
              '취소',
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text(
              '친구 삭제',
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              // TODO: 친구 삭제 처리 - 상태 관리 도입 후 리스트 갱신
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$name님이 친구 목록에서 삭제되었습니다')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          '친구 정보',
          style: TextStyle(
            color: Color(0xFF021F59),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey.shade400,
                child: Icon(Icons.person, size: 48, color: Colors.white),
              ),
              SizedBox(height: 18),
              Text(
                name,
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              SizedBox(height: 24),

              isFriend
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(),
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      ),
                      onPressed: () => _showDeleteDialog(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 18),
                          SizedBox(width: 8),
                          Text('친구'),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD0F252),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(),
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$name님을 친구로 추가했습니다')),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const ListFriendPage()),
                          (route) => route.isFirst,
                        );
                      },
                      child: Text('친구 추가'),
                    ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '활동지역 및 거주지',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('서울특별시 마포구'),
                    ),
                    SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '자기소개',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        Text(
                          '0/150',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '러닝과 커피를 좋아하는 사람입니다.\n주말엔 한강에서 자주 달립니다!',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

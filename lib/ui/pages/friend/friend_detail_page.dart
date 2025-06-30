import 'package:flutter/material.dart';

class FriendDetailPage extends StatelessWidget {
  final String name;
  final String email;

  const FriendDetailPage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              '#$name',
              style: TextStyle(
                color: Color(0xFF021F59),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
              ElevatedButton(
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
                  Navigator.pop(context);
                },
                child: Text('친구 추가'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

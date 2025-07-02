import 'package:flutter/material.dart';

class DeleteSuccessPage extends StatelessWidget {
  const DeleteSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("삭제되었습니다.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text("계정과 관련된 모든 데이터가 삭제되었습니다."),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // 홈으로 이동
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD0F252)),
                child: Text("회원가입 화면으로 이동", style: TextStyle(color: Color(0xFF021F59))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

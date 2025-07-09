import 'package:flutter/material.dart';

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFF9FAEB),
      title: Text(
        "로그아웃 하시겠습니까?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "취소",
            style: TextStyle(color: Color(0xFF021F59)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // 다이얼로그 닫기
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          },
          child: Text(
            "확인",
            style: TextStyle(color: Color(0xFF021F59)),
          ),
        ),
      ],
    );
  }
}

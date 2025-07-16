import 'package:flutter/material.dart';

class InviteFriendTitle extends StatelessWidget {
  const InviteFriendTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '친구 추가하여 초대하기',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Color(0xFF021F59),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class AddFriendSearchGuide extends StatelessWidget {
  const AddFriendSearchGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '태그를 입력하세요',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        Gap.s,
        Text(
          '친구를 찾기 위해 #태그를 입력하세요.\n예: #ssar, #green',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF021F59),
          ),
        ),
      ],
    );
  }
}

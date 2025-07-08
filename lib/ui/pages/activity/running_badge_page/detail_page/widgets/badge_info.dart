import 'package:flutter/material.dart';

class BadgeInfo extends StatelessWidget {
  const BadgeInfo({
    super.key,
    required this.subtitle,
    required this.isAchieved,
  });

  final String? subtitle;
  final bool isAchieved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        subtitle != null
            ? subtitle!
            : isAchieved
            ? '메달을 획득했습니다!'
            : '메달 설명',
        style: TextStyle(
          fontSize: 16,
          color: !isAchieved ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
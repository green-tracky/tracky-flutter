import 'package:flutter/material.dart';

class BadgeTitle extends StatelessWidget {
  const BadgeTitle({
    super.key,
    required this.title,
    required this.isAchieved,
  });

  final String title;
  final bool isAchieved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: !isAchieved ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
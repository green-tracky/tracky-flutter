import 'package:flutter/material.dart';

class LatestDate extends StatelessWidget {
  const LatestDate({
    super.key,
    required this.date,
    required this.isAchieved,
  });

  final String date;
  final bool isAchieved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        date,
        style: TextStyle(
          fontSize: 16,
          color: !isAchieved ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
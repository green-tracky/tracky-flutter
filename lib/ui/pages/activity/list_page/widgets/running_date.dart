import 'package:flutter/material.dart';

class RunningDate extends StatelessWidget {
  const RunningDate({
    super.key,
    required this.date,
    required this.dayTime,
  });

  final String date;
  final String dayTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(dayTime, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

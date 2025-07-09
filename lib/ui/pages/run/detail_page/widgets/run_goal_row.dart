import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunGoalRowSection extends StatelessWidget {
  final RunResult result;

  const RunGoalRowSection({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final goalKm = (result.totalDistanceMeters / 1000).toStringAsFixed(2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '목표 거리',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Text(
          '$goalKm km',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

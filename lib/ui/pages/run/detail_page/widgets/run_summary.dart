// widgets/run_summary.dart

import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/model/activity.dart';

class RunSummarySection extends StatelessWidget {
  final RunResult result;

  const RunSummarySection({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          result.distance.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        Text(
          "킬로미터",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

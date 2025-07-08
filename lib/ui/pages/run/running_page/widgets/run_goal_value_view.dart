import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunGoalValueView extends StatelessWidget {
  const RunGoalValueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '0.00',
            style: TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
          Gap.s,
          Text(
            '킬로미터',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: AppColors.trackyIndigo,
            ),
          ),
        ],
      ),
    );
  }
}

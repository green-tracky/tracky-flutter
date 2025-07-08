// run_start_button.dart
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunStartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RunStartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 150,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(60),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.trackyNeon,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '시작',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.trackyIndigo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

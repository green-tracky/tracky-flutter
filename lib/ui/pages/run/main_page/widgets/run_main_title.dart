import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunMainTitle extends StatelessWidget {
  const RunMainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        '러닝',
        style: AppTextStyles.pageTitle,
      ),
    );
  }
}

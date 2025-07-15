import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class CommonTitle extends StatelessWidget {
  String title;

  CommonTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.pageTitle,
    );
  }
}
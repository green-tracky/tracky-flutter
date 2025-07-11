import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class FilterTitle extends StatelessWidget {
  String title;


  FilterTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.semiTitle,
    );
  }
}

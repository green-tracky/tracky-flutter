// widgets/run_info_item.dart

import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const RunInfoItem({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Gap.ss,
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

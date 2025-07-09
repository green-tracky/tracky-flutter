import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSectionRow extends StatelessWidget {
  final RunSection section;

  const RunSectionRow({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${section.kilometer} km', style: _textStyle),
          Text(section.pace, style: _textStyle),
          Text('${section.variation}', style: _textStyle),
        ],
      ),
    );
  }

  TextStyle get _textStyle => const TextStyle(
    fontSize: 18,
    color: AppColors.trackyIndigo,
  );
}

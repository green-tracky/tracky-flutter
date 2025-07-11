import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSectionRow extends StatelessWidget {
  final RunSection section;

  const RunSectionRow({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${section.kilometer.toStringAsFixed(1)} km',
              style: _textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              formatPace(section.pace),
              style: _textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              formatVariation(section.variation),
              style: _textStyle.copyWith(
                color: section.variation < 0 ? Colors.green : AppColors.trackyIndigo,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String formatPace(String raw) {
    if (!raw.contains(":")) return raw;
    final parts = raw.split(":");
    return "${parts[0]}'${parts[1]}''";
  }

  String formatVariation(int seconds) {
    final abs = seconds.abs();
    final min = (abs ~/ 60).toString();
    final sec = (abs % 60).toString().padLeft(2, '0');
    final sign = seconds < 0 ? "-" : "+";
    return "$sign$min'$sec''";
  }

  TextStyle get _textStyle => const TextStyle(
    fontSize: 18,
    color: AppColors.trackyIndigo,
  );
}

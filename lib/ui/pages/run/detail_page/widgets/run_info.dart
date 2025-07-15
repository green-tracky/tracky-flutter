import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunInfoRow extends StatelessWidget {
  final RunResult result;
  const RunInfoRow({required this.result, super.key});

  String formatPace(int pace) {
    final min = pace ~/ 60;
    final sec = (pace % 60).toString().padLeft(2, '0');
    return "$min'$sec\"";
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildExpandedInfo(formatPace(result.avgPace), "평균 페이스"),
        _buildExpandedInfo(formatTime(result.totalDurationSeconds), "시간"),
        _buildExpandedInfo("${result.calories}", "칼로리"),
      ],
    );
  }

  Widget _buildExpandedInfo(String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Gap.ss,
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

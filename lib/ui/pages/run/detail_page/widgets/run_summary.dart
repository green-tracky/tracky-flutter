import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_info.dart';

class RunSummarySection extends StatelessWidget {
  final RunResult result;

  const RunSummarySection({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    final distanceKm = (result.totalDistanceMeters / 1000).toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          distanceKm,
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        Text(
          "킬로미터",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}

class RunDetailStatsSection extends StatelessWidget {
  final RunResult result;

  const RunDetailStatsSection({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RunSummarySection(result: result),
        Gap.l,
        RunInfoRow(result: result),
      ],
    );
  }
}

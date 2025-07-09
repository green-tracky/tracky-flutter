import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/runsegment_detail_page/segment_detail_page.dart';

class RunGoalRowSection extends StatelessWidget {
  final RunResult result;

  const RunGoalRowSection({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("구간", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        Gap.l,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Km", style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Gap.l,
                  Text(result.distance.toStringAsFixed(2), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("평균 페이스", style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Gap.l,
                  Text(result.averagePace, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
        Gap.m,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RunSegmentDetailPage(
                    startTime: result.startTime,
                    endTime: result.endTime,
                    distance: result.distance,
                    averagePace: result.averagePace,
                    bestPace: "10'41''",
                    runDuration: result.time,
                    totalDuration: result.time,
                    calories: result.calories,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.trackyNeon,
              foregroundColor: AppColors.trackyIndigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
            child: Text("상세 정보", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/runsegment_detail_page/segment_detail_page.dart';

class RunSectionSummary extends StatelessWidget {
  final RunResult result;
  const RunSectionSummary({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    final segment = result.segments.first;
    final distanceKm = (segment.distanceMeters / 1000).toStringAsFixed(2);
    final pace = formatPace(segment.pace);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("구간", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Gap.l,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Km", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Gap.l,
                  Text(distanceKm, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("평균 페이스", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Gap.l,
                  Text(pace, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        Gap.l,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.trackyNeon,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              padding: EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RunSegmentDetailPage(
                    segment: segment,
                    calories: result.calories,
                  ),
                ),
              );
            },
            child: Text("상세 정보", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  String formatPace(int pace) {
    final min = pace ~/ 60;
    final sec = (pace % 60).toString().padLeft(2, '0');
    return "$min'$sec\"";
  }
}

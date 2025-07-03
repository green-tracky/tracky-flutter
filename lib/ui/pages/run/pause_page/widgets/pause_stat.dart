import 'package:flutter/material.dart';

class PausedStatDisplay extends StatelessWidget {
  final String distance;
  final String time;
  final String calorie;
  final String pace;

  PausedStatDisplay({
    required this.distance,
    required this.time,
    required this.calorie,
    required this.pace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricColumn(distance, "킬로미터"),
              _buildMetricColumn(time, "시간"),
              _buildMetricColumn(calorie, "칼로리"),
            ],
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(pace, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("평균 페이스", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

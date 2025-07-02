import 'package:flutter/material.dart';
import 'package:nike1/activity/activity.dart'; // RecordRange enum 사용 시 필요

class TotalRecord extends StatelessWidget {
  final RecordRange range;

  const TotalRecord({super.key, required this.range});

  @override
  Widget build(BuildContext context) {
    // 제목
    String title;
    // 기록값
    String totalDistance;
    String km;
    String pace;
    String time;

    switch (range) {
      case RecordRange.week:
        title = "이번 주 기록";
        totalDistance = "0.31";
        km = "0.15";
        pace = "14'11''";
        time = "02:12";
        break;
      case RecordRange.month:
        title = "이번 달 기록";
        totalDistance = "2.42";
        km = "1.88";
        pace = "12'00''";
        time = "25:00";
        break;
      case RecordRange.year:
        title = "올해 기록";
        totalDistance = "12.8";
        km = "4.56";
        pace = "10'22''";
        time = "1:40:00";
        break;
      case RecordRange.all:
        title = "전체 기록";
        totalDistance = "50.2";
        km = "12.34";
        pace = "9'45''";
        time = "4:32:00";
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Column(
          children: [
            Text(
              totalDistance,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Text("킬로미터"),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(km, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text("Km", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(pace, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text("평균 페이스", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text("시간", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

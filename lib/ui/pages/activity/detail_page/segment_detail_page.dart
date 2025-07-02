import 'package:flutter/material.dart';

class RunSegmentDetailPage extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final double distance;
  final String averagePace;
  final String bestPace;
  final String runDuration;
  final String totalDuration;
  final int calories;

  const RunSegmentDetailPage({
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.averagePace,
    required this.bestPace,
    required this.runDuration,
    required this.totalDuration,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      const weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
      return '${date.month}월 ${date.day}일 ${weekdays[date.weekday - 1]}';
    }

    String formatTime(DateTime date) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        foregroundColor: Color(0xFF021F59),
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatDate(startTime),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
            ),

            SizedBox(height: 12),

            Text(
              '${formatTime(startTime)} - ${formatTime(endTime)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            _DataRow(label: '거리', value: '${distance.toStringAsFixed(2)} km'),
            _DataRow(label: '평균 페이스', value: '$averagePace /km'),
            _DataRow(label: '최고 페이스', value: '$bestPace /km'),
            _DataRow(label: '러닝 시간', value: runDuration),
            _DataRow(label: '경과 시간', value: totalDuration),
            _DataRow(label: '칼로리(근사치)', value: '$calories kcal', showDivider: false),
            SizedBox(height: 28),
            Text(
              '구간',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF021F59)),
            ),

            SizedBox(height: 36),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('KM', style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                SizedBox(width: 80),
                Text('평균 페이스', style: TextStyle(color: Colors.grey[600], fontSize: 18)),
              ],
            ),
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${distance.toStringAsFixed(2)}', style: TextStyle(color: Color(0xFF021F59), fontSize: 18)),
                SizedBox(width: 80),
                Text(averagePace, style: TextStyle(color: Color(0xFF021F59), fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const _DataRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(color: Colors.grey[400], thickness: 0.8),
      ],
    );
  }
}

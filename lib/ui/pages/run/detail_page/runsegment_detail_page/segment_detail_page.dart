import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSegmentDetailPage extends StatelessWidget {
  final RunSegment segment;
  final int calories;

  const RunSegmentDetailPage({
    super.key,
    required this.segment,
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

    String formatPace(int pace) {
      final min = pace ~/ 60;
      final sec = (pace % 60).toString().padLeft(2, '0');
      return "$min'$sec\"";
    }

    String formatDuration(int sec) {
      final m = (sec ~/ 60).toString().padLeft(2, '0');
      final s = (sec % 60).toString().padLeft(2, '0');
      return "$m:$s";
    }

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        foregroundColor: AppColors.trackyIndigo,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatDate(segment.startDate),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.trackyIndigo),
            ),
            Gap.s,
            Text(
              '${formatTime(segment.startDate)} - ${formatTime(segment.endDate)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            Gap.m,
            _DataRow(label: '거리', value: '${(segment.distanceMeters / 1000).toStringAsFixed(2)} km'),
            _DataRow(label: '평균 페이스', value: '${formatPace(segment.pace)} /km'),
            _DataRow(label: '최고 페이스', value: '${formatPace(segment.pace)} /km'), // 추후 bestPace 분리 가능
            _DataRow(label: '러닝 시간', value: formatDuration(segment.durationSeconds)),
            _DataRow(label: '경과 시간', value: formatDuration(segment.durationSeconds)), // 임시 동일 처리
            _DataRow(label: '칼로리(근사치)', value: '$calories kcal', showDivider: false),

            Gap.xxl,
            Text(
              "구간",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: AppColors.trackyIndigo),
            ),
            Gap.l,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("KM", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Gap.l,
                      Text(
                        (segment.distanceMeters / 1000).toStringAsFixed(2),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.trackyIndigo),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("평균 페이스", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Gap.l,
                      Text(
                        formatPace(segment.pace),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.trackyIndigo),
                      ),
                    ],
                  ),
                ),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.trackyIndigo),
              ),
            ],
          ),
        ),
        if (showDivider) Divider(color: Colors.grey[400], thickness: 0.8),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/running_card.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/recent_widgets/recent_to_all.dart';

class Recent extends ConsumerWidget {
  const Recent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(activityProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (model != null) const RecentToAll(),
          Gap.s,
          if (model == null)
            Container()
          else
            ...model.recentRuns.map((item) {
              return RunningCard(
                runId: item['id'],
                date: _formatDate(item['createdAt']),
                // 또는 'date' 필드로 바꾸기
                dayTime: item['title'],
                // 예: '수요일 저녁 러닝'
                distance: (item['totalDistanceMeters'] / 1000).toStringAsFixed(
                  2,
                ),
                pace: _formatPace(item['avgPace']),
                time: _formatDuration(item['totalDurationSeconds']),
                badges: (item['badges'] as List<dynamic>?)
                    ?.map((b) => b['name'].toString())
                    .toList(), // 아이콘 매핑은 실제 구조에 맞게 수정
              );
            }).toList(),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy. MM. dd').format(date);
    } catch (e) {
      return '-';
    }
  }

  String _formatPace(int? paceInSeconds) {
    if (paceInSeconds == null) return "-";
    final min = (paceInSeconds / 60).floor();
    final sec = paceInSeconds % 60;
    return "$min'${sec.toString().padLeft(2, '0')}''";
  }

  String _formatDuration(int? seconds) {
    if (seconds == null) return "-";
    final min = (seconds / 60).floor();
    final sec = seconds % 60;
    return '${min}:${sec.toString().padLeft(2, '0')}';
  }
}

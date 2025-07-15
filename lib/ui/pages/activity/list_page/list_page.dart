import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/filter/filter.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/list_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/running_card.dart';

class RunningListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(runningListProvider);

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: _appBar(context),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('에러 발생: $err')),
        data: (runs) {
          // 월별 그룹핑
          final groupedByMonth = <String, List<Run>>{};
          for (final run in runs) {
            final key = DateFormat('yyyy년 M월').format(run.createdAt);
            groupedByMonth.putIfAbsent(key, () => []).add(run);
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: groupedByMonth.entries.map((entry) {
              final totalDistance = entry.value.fold<double>(
                0.0,
                    (sum, r) => sum + r.distance,
              );
              final totalDuration = entry.value.fold<int>(
                0,
                    (sum, r) => sum + r.durationSeconds,
              );
              final avgPace = totalDistance == 0
                  ? '0\'00\'\''
                  : _formatPace(totalDuration ~/ totalDistance);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.xl,
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap.s,
                  Text(
                    "러닝 ${entry.value.length}회  ${totalDistance.toStringAsFixed(2)}km  $avgPace/km",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Gap.l,
                  ...entry.value.map((run) => RunningCard(
                    runId: run.id,
                    date: DateFormat('yyyy. M. d.').format(run.createdAt),
                    dayTime: run.title,
                    distance: run.distance.toStringAsFixed(2),
                    pace: _formatPace(run.avgPace),
                    time: _formatDuration(run.durationSeconds),
                    badges: run.badges.map((b) => b.imageUrl).toList(),
                  )),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAEB),
      leading: const BackButton(color: Colors.black),
      title: const Text('모든 활동', style: AppTextStyles.appBarTitle),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.black),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RunningFilterPage()),
            );
            if (result != null) {
              // 필터 로직
            }
          },
        ),
      ],
    );
  }

  String _formatPace(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return "$minutes'${seconds.toString().padLeft(2, '0')}''";
  }

  String _formatDuration(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min}:${sec.toString().padLeft(2, '0')}';
  }
}

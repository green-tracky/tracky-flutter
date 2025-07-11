import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

class RunPausedMetrics extends ConsumerWidget {
  const RunPausedMetrics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(runRunningProvider).value!;

    final minutes = (run.time ~/ 60).toString().padLeft(2, '0');
    final seconds = (run.time % 60).toString().padLeft(2, '0');
    final distance = run.distance;

    // 실시간 페이스 계산
    final String paceStr;
    if (distance > 0) {
      final secPerKm = (run.time / distance).round();
      final min = (secPerKm ~/ 60).toString().padLeft(2, '0');
      final sec = (secPerKm % 60).toString().padLeft(2, '0');
      paceStr = "$min'$sec\"";
    } else {
      paceStr = "_'__\"";
    }

    // 실시간 누적 칼로리 계산
    final stats = ref.read(runRunningProvider.notifier).getRealtimeStats();

    final totalCalories = stats.fold<double>(0, (sum, e) => sum + e.calories);
    final caloriesStr = totalCalories > 0 ? totalCalories.toStringAsFixed(0) : "-";

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _Metric(
                    value: distance.toStringAsFixed(2),
                    label: '킬로미터',
                  ),
                ),
                Expanded(
                  child: _Metric(
                    value: '$minutes:$seconds',
                    label: '시간',
                  ),
                ),
                Expanded(
                  child: _Metric(
                    value: caloriesStr,
                    label: '칼로리',
                  ),
                ),
              ],
            ),
          ),
          Gap.xxl,
          Text(
            paceStr,
            style: AppTextStyles.pageTitle.copyWith(color: AppColors.trackyIndigo),
          ),
          Gap.ss,
          Text(
            '페이스',
            style: AppTextStyles.content.copyWith(color: AppColors.trackyIndigo),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.pageTitle,
        ),
        Gap.ss,
        Text(
          label,
          style: AppTextStyles.content.copyWith(color: AppColors.trackyIndigo),
        ),
      ],
    );
  }
}

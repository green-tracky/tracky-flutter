import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page_vm.dart';

/// Metrics display for paused run, now showing dynamic average pace
class RunPausedMetrics extends ConsumerWidget {
  const RunPausedMetrics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(runPausedProvider);
    final minutes = state.elapsedTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = state.elapsedTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    final pace = state.avgPace;
    final paceStr = pace == Duration.zero
        ? "-'-''"
        : '${pace.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
              '${pace.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        children: [
          // Metrics row: distance, time, calories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _Metric(
                    value: state.distance.toStringAsFixed(2),
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
                    value: state.calories.toString(),
                    label: '칼로리',
                  ),
                ),
              ],
            ),
          ),
          Gap.m,
          // Dynamic average pace
          Text(
            paceStr,
            style: AppTextStyles.pageTitle.copyWith(color: AppColors.trackyIndigo),
          ),
          Gap.ss,
          // Average pace label
          Text(
            '평균 페이스',
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

  const _Metric({required this.value, required this.label});

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

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
    final avgPaceSec = distance > 0 ? (run.time / distance).round() : 0;

    final paceMin = (avgPaceSec ~/ 60).toString();
    final paceSec = (avgPaceSec % 60).toString().padLeft(2, '0');
    final avgPaceStr = distance > 0 ? "$paceMin'$paceSec''" : "_'__''";

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Column(
        children: [
          // 거리, 시간, 칼로리 (칼로리는 없으면 숨겨도 됨)
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
                    value: '-', // 칼로리 추후 계산되면 반영
                    label: '칼로리',
                  ),
                ),
              ],
            ),
          ),
          Gap.xxl,
          Text(
            avgPaceStr,
            style: AppTextStyles.pageTitle.copyWith(color: AppColors.trackyIndigo),
          ),
          Gap.ss,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

class RunGoalValueView extends ConsumerWidget {
  const RunGoalValueView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(runRunningProvider).value;

    return Align(
      alignment: const Alignment(0, -0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            run?.distance.toStringAsFixed(2) ?? '0.00',
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
          Gap.ss,
          const Text(
            '킬로미터',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: AppColors.trackyIndigo,
            ),
          ),
        ],
      ),
    );
  }
}

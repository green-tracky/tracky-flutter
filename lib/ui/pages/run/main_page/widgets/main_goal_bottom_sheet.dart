// main_goal_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

void showGoalSettingBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.trackyBGreen,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _GoalOption(label: "거리", type: RunGoalType.distance, ref: ref),
          Gap.s,
          _GoalOption(label: "시간", type: RunGoalType.time, ref: ref),
          Gap.s,
          _GoalOption(label: "스피드", type: RunGoalType.speed, ref: ref),
        ],
      ),
    ),
  );
}

class _GoalOption extends StatelessWidget {
  final String label;
  final RunGoalType type;
  final WidgetRef ref;

  const _GoalOption({required this.label, required this.type, required this.ref});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ref.read(runGoalTypeProvider.notifier).state = type;
        Navigator.pop(context);

        if (type == RunGoalType.time) {
          ref.read(runGoalValueProvider.notifier).state = 1800;
        } else if (type == RunGoalType.distance) {
          ref.read(runGoalValueProvider.notifier).state = 5.0;
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RunMainPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.trackyNeon,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: AppColors.trackyIndigo),
          ),
        ),
      ),
    );
  }
}

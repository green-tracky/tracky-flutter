import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page_vm.dart';

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
        children: const [
          _GoalOption(label: "거리", type: GoalType.distance),
          Gap.s,
          _GoalOption(label: "시간", type: GoalType.time),
          Gap.s,
        ],
      ),
    ),
  );
}

class _GoalOption extends ConsumerWidget {
  final String label;
  final GoalType type;

  const _GoalOption({required this.label, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        final vm = ref.read(runMainProvider.notifier);
        vm.setGoalType(type);

        if (type == GoalType.time) {
          vm.updateGoalTime(1800); // 30분
        } else if (type == GoalType.distance) {
          vm.updateGoalDistance(5.0); // 5km
        }

        Navigator.pop(context);
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

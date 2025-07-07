import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/time_setting_page.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/utils/my_utils.dart';

class GoalValueDisplay extends ConsumerWidget {
  const GoalValueDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalType = ref.watch(runGoalTypeProvider);
    final goalValue = ref.watch(runGoalValueProvider);

    if (goalValue == null) return SizedBox.shrink();

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          onTap: () async {
            if (goalType == RunGoalType.time) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TimeSettingPage(initialValue: goalValue.toInt()),
                ),
              );
            } else if (goalType == RunGoalType.distance) {
              final result = await Navigator.push<double>(
                context,
                MaterialPageRoute(
                  builder: (_) => DistanceSettingPage(initialDistance: goalValue),
                ),
              );
              if (result != null) {
                ref.read(runGoalValueProvider.notifier).state = result;
              }
            }
          },
          child: Column(
            children: [
              Text(
                goalType == RunGoalType.time
                    ? formatTimeFromSeconds(goalValue.toInt())
                    : goalValue.toStringAsFixed(2),
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Container(width: 160, height: 2, color: Colors.black),
              SizedBox(height: 4),
              Text(
                goalType == RunGoalType.time ? "시간 : 분" : "킬로미터",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

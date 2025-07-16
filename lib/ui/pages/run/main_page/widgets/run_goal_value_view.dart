import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page_vm.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/time_setting_page.dart';
import 'package:tracky_flutter/utils/my_utils.dart';

class RunGoalValueView extends ConsumerWidget {
  const RunGoalValueView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(runMainProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    if (state.goalType == null) {
      return const SizedBox.shrink();
    }

    if (state.goalType == GoalType.time) {
      return Positioned(
        top: screenHeight * 0.15,
        left: 0,
        right: 0,
        child: Center(
          child: InkWell(
            onTap: () async {
              final result = await Navigator.push<int>(
                context,
                MaterialPageRoute(
                  builder: (_) => TimeSettingPage(initialValue: state.goalTimeInSeconds),
                ),
              );
              if (result != null) {
                ref.read(runMainProvider.notifier).updateGoalTime(result);
                ref.read(runMainProvider.notifier).setGoalType(GoalType.time);
              }
            },
            child: Column(
              children: [
                Text(
                  formatTimeFromSeconds(state.goalTimeInSeconds),
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(width: 160, height: 2, color: Colors.black),
                Gap.ss,
                const Text("시간 : 분", style: TextStyle(fontSize: 25, color: Colors.black)),
              ],
            ),
          ),
        ),
      );
    } else if (state.goalType == GoalType.distance && state.goalDistance > 0) {
      return Positioned(
        top: screenHeight * 0.15,
        left: 0,
        right: 0,
        child: Center(
          child: InkWell(
            onTap: () async {
              final result = await Navigator.push<double>(
                context,
                MaterialPageRoute(
                  builder: (_) => DistanceSettingPage(initialDistance: state.goalDistance),
                ),
              );
              if (result != null) {
                ref.read(runMainProvider.notifier).updateGoalDistance(result);
              }
            },
            child: Column(
              children: [
                Text(
                  state.goalDistance.toStringAsFixed(2),
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(width: 160, height: 2, color: Colors.black),
                Gap.ss,
                const Text("킬로미터", style: AppTextStyles.semiTitle),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

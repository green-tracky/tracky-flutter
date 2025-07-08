// run_goal_value_view.dart
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/time_setting_page.dart';
import 'package:tracky_flutter/utils/my_utils.dart';

class RunGoalValueView extends StatelessWidget {
  final RunGoalType? goalType;
  final double? goalValue;

  const RunGoalValueView({super.key, required this.goalType, required this.goalValue});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (goalType == RunGoalType.time && goalValue != null) {
      return Positioned(
        top: screenHeight * 0.15,
        left: 0,
        right: 0,
        child: Center(
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TimeSettingPage(initialValue: goalValue!.toInt()),
              ),
            ),
            child: Column(
              children: [
                Text(
                  formatTimeFromSeconds(goalValue!.toInt()),
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(width: 160, height: 2, color: Colors.black),
                Gap.ss,
                Text("시간 : 분", style: TextStyle(fontSize: 25, color: Colors.black)),
              ],
            ),
          ),
        ),
      );
    } else if (goalType == RunGoalType.distance && goalValue != null) {
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
                  builder: (_) => DistanceSettingPage(initialDistance: goalValue!),
                ),
              );
              if (result != null) {
                // TODO: Riverpod 상태 업데이트 로직 연결 예정
              }
            },
            child: Column(
              children: [
                Text(
                  goalValue!.toStringAsFixed(2),
                  style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(width: 160, height: 2, color: Colors.black),
                Gap.ss,
                Text("킬로미터", style: TextStyle(fontSize: 25, color: Colors.black)),
              ],
            ),
          ),
        ),
      );
    } else if (goalType == RunGoalType.speed) {
      return Positioned(
        top: screenHeight * 0.10,
        left: 0,
        right: 0,
        child: Center(
          child: Text(
            '러닝 중 랩을\n기록하세요',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

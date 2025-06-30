import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

void showGoalSettingBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Color(0xFFF9FAEB),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildGoalOption("거리", RunGoalType.distance, ref, context),
          SizedBox(height: 12),
          buildGoalOption("시간", RunGoalType.time, ref, context),
          SizedBox(height: 12),
          buildGoalOption("스피드", RunGoalType.speed, ref, context),
        ],
      ),
    ),
  );
}

Widget buildGoalOption(String label, RunGoalType type, WidgetRef ref, BuildContext context) {
  return InkWell(
    onTap: () {
      ref.read(runGoalTypeProvider.notifier).state = type;
      Navigator.pop(context);

      if (type == RunGoalType.time) {
        ref.read(runGoalTypeProvider.notifier).state = RunGoalType.time;
        ref.read(runGoalValueProvider.notifier).state = 1800;
        Navigator.push(context, MaterialPageRoute(builder: (_) => RunMainPage()));
      } else if (type == RunGoalType.distance) {
        ref.read(runGoalValueProvider.notifier).state = 5.0;
        Navigator.push(context, MaterialPageRoute(builder: (_) => RunMainPage()));
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Color(0xFFD0F252), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(label, style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
      ),
    ),
  );
}

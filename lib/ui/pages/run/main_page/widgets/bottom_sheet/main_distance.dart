import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';

Widget buildDistanceGoal(BuildContext context, WidgetRef ref, double goalValue) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.15,
    left: 0,
    right: 0,
    child: Center(
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push<double>(
            context,
            MaterialPageRoute(builder: (_) => DistanceSettingPage(initialDistance: goalValue)),
          );
          if (result != null) {
            ref.read(runGoalValueProvider.notifier).state = result;
          }
        },
        child: Column(
          children: [
            Text(
              goalValue.toStringAsFixed(2),
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Container(width: 160, height: 2, color: Colors.black),
            const SizedBox(height: 5),
            const Text("킬로미터", style: TextStyle(fontSize: 25, color: Colors.black)),
          ],
        ),
      ),
    ),
  );
}

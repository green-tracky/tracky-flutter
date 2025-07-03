import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/setting/time_setting_page.dart';
import 'package:tracky_flutter/utils/my_utils.dart';

Widget buildTimeGoal(BuildContext context, int goalValue) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.15,
    left: 0,
    right: 0,
    child: Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TimeSettingPage(initialValue: 0)),
          );
        },
        child: Column(
          children: [
            Text(
              formatTimeFromSeconds(goalValue.toInt()),
              style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Container(width: 160, height: 2, color: Colors.black),
            const SizedBox(height: 4),
            const Text("시간 : 분", style: TextStyle(fontSize: 25, color: Colors.black)),
          ],
        ),
      ),
    ),
  );
}

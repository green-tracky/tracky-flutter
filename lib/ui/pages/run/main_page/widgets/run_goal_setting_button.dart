// run_goal_setting_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_goal_bottom_sheet.dart';

class RunGoalSettingButton extends ConsumerWidget {
  const RunGoalSettingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () => showGoalSettingBottomSheet(context, ref),
            icon: const Icon(Icons.flag, color: Colors.black, size: 25),
            label: const Text(
              "목표설정",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: const Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

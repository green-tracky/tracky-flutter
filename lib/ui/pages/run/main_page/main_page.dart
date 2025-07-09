// run_main_page.dart (타이틀 포함 버전)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_goal_setting_button.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_goal_value_view.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_main_appbar.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_main_title.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_map_section.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_start_button.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

class RunMainPage extends ConsumerWidget {
  const RunMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalType = ref.watch(runGoalTypeProvider);
    final goalValue = ref.watch(runGoalValueProvider);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const RunMainAppBar(),
      backgroundColor: AppColors.trackyBGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap.ss,
          const RunMainTitle(),
          Gap.l,
          Expanded(
            child: Stack(
              children: [
                const RunMapSection(),
                RunGoalValueView(goalType: goalType, goalValue: goalValue),
                RunStartButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RunRunningPage()),
                  ),
                ),
                const RunGoalSettingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

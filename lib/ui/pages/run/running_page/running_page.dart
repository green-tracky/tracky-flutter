import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

import '../section_page/section_page.dart';
import 'widgets/run_action_button.dart';
import 'widgets/run_goal_value_view.dart';
import 'widgets/run_pause_button.dart';
import 'widgets/run_top_info.dart';

class RunRunningPage extends ConsumerStatefulWidget {
  const RunRunningPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RunRunningPage> createState() => _RunRunningPageState();
}

class _RunRunningPageState extends ConsumerState<RunRunningPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(runRunningProvider.notifier).startNewRun(1);
      // ref.read(runRunningProvider.notifier).loadExistingRun(18);
    });
  }

  void onSwipeLeft(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const RunSectionPage(),
        transitionsBuilder: (_, animation, __, child) {
          final tween = Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < -20) onSwipeLeft(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.trackyNeon,
        body: SafeArea(
          child: Stack(
            children: const [
              RunGoalValueView(),
              RunPauseButton(),
              RunTopInfo(),
              RunActionButton(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/run_pasued_map.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/run_paused_button.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/run_paused_metrics.dart';

class RunPausedPage extends ConsumerWidget {
  const RunPausedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      body: SafeArea(
        child: Column(
          children: [
            RunPausedMap(),
            Gap.xxl,
            RunPausedMetrics(),
            Gap.xxl,
            RunPausedButtons(),
          ],
        ),
      ),
    );
  }
}

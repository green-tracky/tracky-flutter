import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

class RunTopInfo extends ConsumerWidget {
  const RunTopInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(runRunningProvider).value;

    final String paceText;
    if (run != null && run.distance > 0) {
      final secPerKm = (run.time / run.distance).round();
      final min = (secPerKm ~/ 60).toString().padLeft(2, '0');
      final sec = (secPerKm % 60).toString().padLeft(2, '0');
      paceText = "$min'$sec\"";
    } else {
      paceText = "_'__\"";
    }

    final String timeText;
    if (run != null) {
      final min = (run.time ~/ 60).toString().padLeft(2, '0');
      final sec = (run.time % 60).toString().padLeft(2, '0');
      timeText = "$min:$sec";
    } else {
      timeText = "00:00";
    }

    return Positioned(
      top: 30,
      left: 30,
      right: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽: 페이스
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                paceText,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                '페이스',
                style: TextStyle(fontSize: 16, color: AppColors.trackyIndigo),
              ),
            ],
          ),

          // 오른쪽: 시간
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                timeText,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                '시간',
                style: TextStyle(fontSize: 16, color: AppColors.trackyIndigo),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

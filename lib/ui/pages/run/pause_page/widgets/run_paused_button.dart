import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/main.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page_vm.dart';

class RunPausedButtons extends ConsumerStatefulWidget {
  const RunPausedButtons({super.key});

  @override
  ConsumerState<RunPausedButtons> createState() => _RunPausedButtonsState();
}

class _RunPausedButtonsState extends ConsumerState<RunPausedButtons> {
  late final pausedVM = ref.read(runPausedProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runPausedProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stop button
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('2초 이상 길게 눌러주세요'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            onLongPress: () {
              pausedVM.pauseRun();
              if (state.distance > 0.0) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => RunDetailPage(runId: 1)),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DummyPage(title: '더미', currentIndex: 1)),
                );
              }
            },
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.stop,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          SizedBox(width: 80),
          // Resume button
          GestureDetector(
            onTap: () {
              pausedVM.resumeRun();
              Navigator.of(context).pop();
            },
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.trackyNeon,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

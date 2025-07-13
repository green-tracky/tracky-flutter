import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/result_page/result_page.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

class RunPausedButtons extends ConsumerWidget {
  const RunPausedButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runState = ref.watch(runRunningProvider);
    final vm = ref.read(runRunningProvider.notifier);

    return runState.when(
      data: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('2초 이상 길게 눌러주세요'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                onLongPress: () async {
                  if (state.distance > 0.0) {
                    final result = await vm.finalizeRun();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          RunDetailPage(runId: 1, initialLocalResult: result),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const RunResultPage(),
                    ));
                  }
                },
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.stop, color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(width: 80),
              GestureDetector(
                onTap: () {
                  vm.setIsRunning(true);
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
                      Icons.play_arrow, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, _) => Center(child: Text('에러: $e')),
    );
  }
}
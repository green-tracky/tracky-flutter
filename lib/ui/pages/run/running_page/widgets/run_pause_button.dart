import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

class RunPauseButton extends ConsumerWidget {
  const RunPauseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(runRunningProvider.notifier);

    return Positioned(
      bottom: 230,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            vm.pause(); // pause 먼저 호출 (섹션 저장)
            vm.setIsRunning(false); //  러닝 상태 false
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RunPausedPage()),
            );
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: const Icon(Icons.pause, color: Colors.white, size: 36),
          ),
        ),
      ),
    );
  }
}

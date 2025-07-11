import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page_vm.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

class RunStartButton extends ConsumerWidget {
  const RunStartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(runMainProvider);
    final isReady = state.isReady;

    return Positioned(
      bottom: 150,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          onTap: isReady
              ? () {
                  // // ✅ 시뮬레이션 실행
                  // final vm = ref.read(runRunningProvider.notifier);
                  // final service = vm.getTrackingService();
                  // final simulator = DummyRunSimulator(service: service);
                  // simulator.startSimulation();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RunRunningPage()),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(60),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.trackyNeon,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '시작',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.trackyIndigo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

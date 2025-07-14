import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';

class RunningLevelCard extends ConsumerWidget {
  const RunningLevelCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(runLevelProvider);

    return model.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('에러 발생: $err'),
      ),
      data: (data) {
        if (data == null) {
          return const SizedBox.shrink();
        }

        final totalKm = data.totalDistance / 1000;
        final nextKm = data.distanceToNextLevel / 1000;
        final currentKm = totalKm;
        final maxKm = totalKm + nextKm;
        final progress = maxKm == 0 ? 0.0 : (currentKm / maxKm).clamp(0.0, 1.0);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 100,
                child: Transform.scale(
                  scale: 1.5,
                  child: Image.asset(
                    "assets/images/tracky_badge_black.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.currentLevel,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${totalKm.toStringAsFixed(1)} km",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.black.withOpacity(0.2),
                      color: Colors.black,
                      minHeight: 6,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "${data.nextLevelName} 레벨까지 ${nextKm.toStringAsFixed(2)} km 남음",
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

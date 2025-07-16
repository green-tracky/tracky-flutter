import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity/activity.dart';

class TotalRecord extends ConsumerWidget {
  final RecordRange range;

  const TotalRecord({super.key, required this.range});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(activityProvider);

    if (model == null) {
      return Container(
        child: const Text(
          "러닝을 뛰어\n기록을 달성해보세요.",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      );
    }

    // 범위별 avgStats 가져오기
    final avgStats = model.avgStats;
    if (avgStats == null) {
      return const Text("기록이 없습니다.");
    }

    // 기본값 세팅
    final totalDistanceKm = (avgStats.totalDistanceMeters ?? 0) / 1000.0;
    final perRunKm = avgStats.recodeCount == 0 ? 0 : totalDistanceKm / avgStats.recodeCount;

    final paceSeconds = avgStats.avgPace ?? 0;
    final paceMin = (paceSeconds ~/ 60).toString();
    final paceSec = (paceSeconds % 60).toString().padLeft(2, '0');

    final durationSeconds = avgStats.totalDurationSeconds ?? 0;
    final hours = (durationSeconds ~/ 3600).toString();
    final minutes = ((durationSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (durationSeconds % 60).toString().padLeft(2, '0');

    // 범위에 따른 타이틀
    String title;
    switch (range) {
      case RecordRange.week:
        title = "이번 주 기록";
        break;
      case RecordRange.month:
        title = "이번 달 기록";
        break;
      case RecordRange.year:
        title = "올해 기록";
        break;
      case RecordRange.all:
        title = "전체 기록";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Column(
            children: [
              Text(
                totalDistanceKm.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Text("킬로미터"),
            ],
          ),
          Gap.xl,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      perRunKm.toStringAsFixed(2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text("Km", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      "$paceMin'$paceSec''",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text("평균 페이스", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      durationSeconds >= 3600 ? "$hours:$minutes:$seconds" : "$minutes:$seconds",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Text("시간", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

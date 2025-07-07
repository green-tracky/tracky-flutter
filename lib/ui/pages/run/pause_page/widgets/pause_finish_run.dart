import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';

void finishRun(BuildContext context, WidgetRef ref) {
  final now = DateTime.now();

  final result = RunResult(
    startTime: DateTime(2025, 6, 17, 8, 44), // TODO: 진짜 시작 시간으로 대체
    endTime: now,
    distance: 0.25, // TODO: 실제 거리 계산값
    averagePace: "12'05''", // TODO: 실제 pace 계산
    time: "03:04", // TODO: 시간 계산 결과
    calories: 15, // TODO: 칼로리 계산
    paths: [
      [
        LatLng(35.1555, 129.0590),
        LatLng(35.1570, 129.0603),
      ],
      [
        LatLng(35.1510, 129.0550),
        LatLng(35.1520, 129.0560),
      ],
    ], // TODO: 실제 구간 리스트
  );

  ref.read(runResultProvider.notifier).state = result;
}

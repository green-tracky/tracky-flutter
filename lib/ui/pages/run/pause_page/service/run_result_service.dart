import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

void saveRunResult(
  BuildContext context,
  WidgetRef ref, {
  double? overrideDistance,
}) {
  final now = DateTime.now();

  final result = RunResult(
    startTime: DateTime(2025, 6, 17, 8, 44),
    endTime: now,
    distance: 0.25, // <= 여기서 덮어쓰기
    averagePace: "12'05\"",
    time: "03:04",
    calories: 15,
    paths: [
      [LatLng(35.1555, 129.0590), LatLng(35.1570, 129.0603)],
      [LatLng(35.1510, 129.0550), LatLng(35.1520, 129.0560)],
    ],
  );

  ref.read(runResultProvider.notifier).state = result;
}

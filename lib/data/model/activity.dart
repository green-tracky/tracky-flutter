import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 러닝 장소 유형
enum RunningSurface { road, track, trail }

/// 러닝 장소 → 한글 라벨
String getSurfaceLabel(RunningSurface surface) {
  switch (surface) {
    case RunningSurface.road:
      return '도로';
    case RunningSurface.track:
      return '트랙';
    case RunningSurface.trail:
      return '산길';
  }
}

/// 러닝 장소 → 아이콘
IconData getSurfaceIcon(RunningSurface surface) {
  switch (surface) {
    case RunningSurface.road:
      return Icons.add_road;
    case RunningSurface.track:
      return Icons.directions_run;
    case RunningSurface.trail:
      return Icons.terrain;
  }
}

/// 한글 라벨 → 러닝 장소 enum
RunningSurface getSurfaceFromLabel(String label) {
  switch (label) {
    case '도로':
      return RunningSurface.road;
    case '트랙':
      return RunningSurface.track;
    case '산길':
      return RunningSurface.trail;
    default:
      throw ArgumentError('Unknown surface label: $label');
  }
}

/// 러닝 기록 데이터
class RunResult {
  final DateTime startTime;
  final DateTime endTime;
  final double distance;
  final String averagePace;
  final String time;
  final int calories;
  final List<List<LatLng>> paths; // 여러 구간 경로

  // ✅ 추가된 필드
  final int? intensity;
  final String? memo;
  final String? place; // 한글로 저장 (ex. '도로')

  RunResult({
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.averagePace,
    required this.time,
    required this.calories,
    required this.paths,
    this.intensity,
    this.memo,
    this.place,
  });
}

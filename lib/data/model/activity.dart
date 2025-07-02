import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum RunningSurface { road, track, trail }

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

class RunResult {
  final DateTime startTime;
  final DateTime endTime;
  final double distance;
  final String averagePace;
  final String time;
  final int calories;
  final List<List<LatLng>> paths; // 여러 구간 경로

  RunResult({
    required this.startTime,
    required this.endTime,
    required this.distance,
    required this.averagePace,
    required this.time,
    required this.calories,
    required this.paths,
  });
}

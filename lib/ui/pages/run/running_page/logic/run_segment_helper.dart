import 'package:geolocator/geolocator.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSegmentHelper {
  // 구간 전체 거리 계산
  static double calculateDistance(List<RunCoordinate> coords) {
    double total = 0.0;
    for (int i = 0; i < coords.length - 1; i++) {
      final a = coords[i];
      final b = coords[i + 1];
      total += Geolocator.distanceBetween(a.lat, a.lon, b.lat, b.lon);
    }
    return total;
  }

  static RunSegment createSegment(List<RunCoordinate> coords) {
    final start = coords.first.recordedAt;
    final end = coords.last.recordedAt;
    final duration = end.difference(start).inSeconds;
    final distance = 500.0;
    // calculateDistance(coords);
    final pace = distance == 0 ? 0 : (duration / (distance / 1000)).round();

    return RunSegment(
      startDate: start,
      endDate: end,
      durationSeconds: duration,
      distanceMeters: distance.round(),
      pace: pace,
      coordinates: List.from(coords),
    );
  }
}

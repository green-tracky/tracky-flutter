import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunStatUtils {
  /// 두 위도/경도 좌표 사이의 거리(m)를 계산합니다.
  static double _degreesToRadians(double degree) => degree * pi / 180;

  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000; // m
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  /// 속도(m/s) → MET 추정
  static double estimateMET(double speedMs) {
    double speedKmh = speedMs * 3.6;
    return double.parse((0.026 * speedKmh * speedKmh + 0.581 * speedKmh + 1.221).toStringAsFixed(2));
  }

  /// 2초 간격 위치 데이터로 거리, 속도, MET, 칼로리 계산
  static Map<String, dynamic> processRunningSegment({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
    required double weightKg,
    int durationSec = 2,
  }) {
    final distanceM = calculateDistance(lat1, lon1, lat2, lon2);
    final speedMs = distanceM / durationSec;
    final met = estimateMET(speedMs);
    final calories = double.parse((met * weightKg * (durationSec / 3600)).toStringAsFixed(2));

    return {
      'distance_m': distanceM,
      'speed_mps': speedMs,
      'met': met,
      'calories_kcal': calories,
    };
  }

  /// 누적 거리(m) 계산
  static int totalDistance(List<RunCoordinate> coords) {
    double total = 0.0;
    for (int i = 0; i < coords.length - 1; i++) {
      final a = coords[i];
      final b = coords[i + 1];
      total += Geolocator.distanceBetween(a.lat, a.lon, b.lat, b.lon);
    }
    return total.round();
  }
}

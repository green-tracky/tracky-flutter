import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum RunGoalType { distance, time, speed }

final runGoalTypeProvider = StateProvider<RunGoalType?>((ref) => null);
final runGoalValueProvider = StateProvider<double?>((ref) => null);
final runDistanceProvider = StateProvider<double>((ref) => 0.0); // 거리 계산

final currentPositionProvider = StateProvider<LatLng?>((ref) => null);
final markerProvider = StateProvider<Set<Marker>>((ref) => {});
final runPositionStreamProvider = Provider<StreamSubscription<Position>?>((ref) {
  return Geolocator.getPositionStream(
    locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
  ).listen((position) {
    final prev = ref.read(currentPositionProvider);
    final newLatLng = LatLng(position.latitude, position.longitude);
    ref.read(currentPositionProvider.notifier).state = newLatLng;

    // 마커 업데이트
    ref.read(markerProvider.notifier).state = {
      Marker(
        markerId: MarkerId("me"),
        position: newLatLng,
        infoWindow: InfoWindow(title: "내 위치"),
      ),
    };

    // 거리 누적
    if (prev != null) {
      final distance = Geolocator.distanceBetween(
        prev.latitude,
        prev.longitude,
        newLatLng.latitude,
        newLatLng.longitude,
      );
      final previous = ref.read(runDistanceProvider);
      ref.read(runDistanceProvider.notifier).state = previous + (distance / 1000);
    }
  });
});

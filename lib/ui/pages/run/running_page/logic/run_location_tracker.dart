import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef PositionCallback = void Function(Position position);

class LocationTracker {
  StreamSubscription<Position>? _subscription;

  void startTracking(PositionCallback onPosition) {
    stopTracking(); // 중복 방지
    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    ).listen(onPosition);
  }

  void stopTracking() {
    _subscription?.cancel();
    _subscription = null;
  }

  bool get isTracking => _subscription != null;
}

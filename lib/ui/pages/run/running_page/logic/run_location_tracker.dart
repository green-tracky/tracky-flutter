import 'dart:async';
import 'package:flutter/foundation.dart'; // <- kIsWeb
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform; // 웹에서는 자동 무시됨

typedef PositionCallback = void Function(Position position);

class LocationTracker {
  StreamSubscription<Position>? _subscription;

  void startTracking(PositionCallback onPosition) {
    stopTracking(); // 중복 방지

    LocationSettings locationSettings;

    if (kIsWeb) {
      // 웹일 경우 (시간 간격 설정 불가)
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 0,
      );
    } else if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 0,
        intervalDuration: Duration(seconds: 2),
      );
    } else if (Platform.isIOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 0,
      );
    } else {
      // 기본값 fallback
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 0,
      );
    }

    _subscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(onPosition);
  }

  void stopTracking() {
    _subscription?.cancel();
    _subscription = null;
  }

  bool get isTracking => _subscription != null;
}

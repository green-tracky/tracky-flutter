import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunPausedState {
  final double distance;
  final int calories;
  final Duration elapsedTime;
  final Duration avgPace;
  final bool isPaused;
  final LatLng? currentPosition;

  RunPausedState({
    required this.distance,
    required this.calories,
    required this.elapsedTime,
    required this.avgPace,
    required this.isPaused,
    this.currentPosition,
  });

  RunPausedState copyWith({
    double? distance,
    int? calories,
    Duration? elapsedTime,
    Duration? avgPace,
    bool? isPaused,
    LatLng? currentPosition,
  }) {
    return RunPausedState(
      distance: distance ?? this.distance,
      calories: calories ?? this.calories,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      avgPace: avgPace ?? this.avgPace,
      isPaused: isPaused ?? this.isPaused,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}

final runPausedProvider = StateNotifierProvider<RunPausedVM, RunPausedState>((ref) {
  return RunPausedVM()..init();
});

class RunPausedVM extends StateNotifier<RunPausedState> {
  RunPausedVM()
    : super(
        RunPausedState(
          distance: 0.0,
          calories: 0,
          elapsedTime: Duration.zero,
          avgPace: Duration.zero,
          isPaused: true,
          currentPosition: null,
        ),
      );

  /// 초기화: 권한 요청 및 위치 가져오기
  Future<void> init() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final latLng = LatLng(pos.latitude, pos.longitude);

    state = state.copyWith(currentPosition: latLng);
  }

  void updateDistance(double newDistance) {
    state = state.copyWith(distance: newDistance);
  }

  void updateCalories(int newCalories) {
    state = state.copyWith(calories: newCalories);
  }

  void updateElapsedTime(Duration time) {
    state = state.copyWith(elapsedTime: time);
  }

  void updateAvgPace(Duration newPace) {
    state = state.copyWith(avgPace: newPace);
  }

  void resumeRun() {
    state = state.copyWith(isPaused: false);
  }

  void pauseRun() {
    state = state.copyWith(isPaused: true);
  }

  void reset() {
    state = RunPausedState(
      distance: 0.0,
      calories: 0,
      elapsedTime: Duration.zero,
      avgPace: Duration.zero,
      isPaused: true,
      currentPosition: null,
    );
  }
}

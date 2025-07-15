// lib/run/main_page/vm/run_main_vm.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum GoalType { distance, time }

class RunMainState {
  final double goalDistance;
  final int goalTimeInSeconds;
  final bool isReady;
  final bool isLoading;
  final LatLng? currentLocation;
  final String? place;
  final int? intensity;
  final String? memo;
  final GoalType? goalType;

  RunMainState({
    required this.goalDistance,
    required this.goalTimeInSeconds,
    this.isReady = false,
    this.isLoading = false,
    this.currentLocation,
    this.place,
    this.intensity,
    this.memo,
    this.goalType = GoalType.distance,
  });

  RunMainState copyWith({
    double? goalDistance,
    int? goalTimeInSeconds,
    bool? isReady,
    bool? isLoading,
    LatLng? currentLocation,
    String? place,
    int? intensity,
    String? memo,
    GoalType? goalType,
  }) {
    return RunMainState(
      goalDistance: goalDistance ?? this.goalDistance,
      goalTimeInSeconds: goalTimeInSeconds ?? this.goalTimeInSeconds,
      isReady: isReady ?? this.isReady,
      isLoading: isLoading ?? this.isLoading,
      currentLocation: currentLocation ?? this.currentLocation,
      place: place ?? this.place,
      intensity: intensity ?? this.intensity,
      memo: memo ?? this.memo,
      goalType: goalType ?? this.goalType,
    );
  }
}

final runMainProvider = StateNotifierProvider<RunMainVM, RunMainState>(
  (ref) => RunMainVM(),
);

class RunMainVM extends StateNotifier<RunMainState> {
  RunMainVM()
    : super(
        RunMainState(
          goalDistance: 0.0,
          goalTimeInSeconds: 0,
          goalType: null,
          isReady: true,
        ),
      );

  void updateGoalDistance(double distance) {
    state = state.copyWith(goalDistance: distance);
  }

  void updateGoalTime(int seconds) {
    state = state.copyWith(goalTimeInSeconds: seconds);
  }

  void setGoalType(GoalType type) {
    state = state.copyWith(goalType: type);
  }

  void setPlace(String place) {
    state = state.copyWith(place: place);
  }

  void setIntensity(int intensity) {
    state = state.copyWith(intensity: intensity);
  }

  void setMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  void updateLocation(LatLng location) {
    state = state.copyWith(currentLocation: location);
  }

  void setReady(bool ready) {
    state = state.copyWith(isReady: ready);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page_vm.dart';

final runRepositoryProvider = Provider<RunRepository>((ref) => RunRepository());

final runRunningProvider = StateNotifierProvider.autoDispose<RunRunningVM, AsyncValue<Run>>((ref) {
  return RunRunningVM(repository: ref.read(runRepositoryProvider), ref: ref);
});

class RunRunningVM extends StateNotifier<AsyncValue<Run>> {
  final RunRepository repository;
  final Ref ref;
  Timer? _ticker;
  StreamSubscription<Position>? _positionStream;

  double _totalDistance = 0.0;
  double _lastSectionDistance = 0.0;
  List<LatLng> _coordinates = [];

  RunRunningVM({required this.repository, required this.ref}) : super(const AsyncLoading());

  List<LatLng> get coordinates => _coordinates;

  Future<void> initRun(int id) async {
    state = const AsyncLoading();
    try {
      final run = await repository.getOneRun(id);
      state = AsyncData(run);
      if (run.isRunning) {
        _startTimer();
        _startListeningLocation(); // 위치 스트림 연결
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void setIsRunning(bool running) {
    state.whenData((run) {
      final updated = run.copyWith(isRunning: running);
      state = AsyncData(updated);
      repository.updateRun(updated);

      if (running) {
        _startTimer();
        _startListeningLocation(); // 위치 스트림 연결
      } else {
        _ticker?.cancel();
        _positionStream?.cancel();
      }
    });
  }

  void _startTimer() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      state.whenData((run) {
        if (!run.isRunning) return;
        final updated = run.copyWith(time: run.time + 1);
        state = AsyncData(updated);
      });
    });
  }

  void _startListeningLocation() {
    _positionStream?.cancel();
    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.best,
            distanceFilter: 0,
          ),
        ).listen((pos) {
          _onNewLocation(pos);
        });
  }

  void _onNewLocation(Position pos) {
    final newLatLng = LatLng(pos.latitude, pos.longitude);
    _coordinates.add(newLatLng);
    debugPrint("좌표 수신됨: $newLatLng");

    final newDistance = _calculateDistanceFromLast(pos);
    _totalDistance += newDistance;

    if (_totalDistance - _lastSectionDistance >= 1.0) {
      _lastSectionDistance = _totalDistance;

      final run = state.value!;
      final nowPace = _calculateCurrentPace(run.time);
      final currentKm = _lastSectionDistance;

      final prev = ref.read(runSectionProvider).last;
      final prevPaceSec = prev != null ? _paceToSeconds(prev.pace) : null;
      final nowPaceSec = _paceToSeconds(nowPace);

      final variation = prevPaceSec != null ? nowPaceSec - prevPaceSec : 0;

      ref
          .read(runSectionProvider.notifier)
          .add(
            RunSection(kilometer: currentKm, pace: nowPace, variation: variation),
          );
    }
  }

  double _calculateDistanceFromLast(Position pos) {
    // TODO: 이전 위치 기억해서 거리 계산하기
    return 0.01; // 임시: 10m씩 증가
  }

  String _calculateCurrentPace(int time) {
    if (_totalDistance == 0) return "0:00";
    final paceSec = time ~/ _totalDistance;
    final min = paceSec ~/ 60;
    final sec = paceSec % 60;
    return "$min:${sec.toString().padLeft(2, '0')}";
  }

  int _paceToSeconds(String pace) {
    final parts = pace.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _positionStream?.cancel();
    super.dispose();
  }
}

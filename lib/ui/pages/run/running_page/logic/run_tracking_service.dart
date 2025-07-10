import 'package:flutter/animation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_location_tracker.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_result_builder.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_segment_helper.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_timer.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page_vm.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/model/activity.dart' hide RunResult;

class RunTrackingService {
  final Ref ref;
  final RunTimer _timer = RunTimer();
  final LocationTracker _tracker = LocationTracker();

  final List<RunCoordinate> _currentCoords = [];
  final List<RunSegment> _segments = [];
  double _totalDistance = 0.0;
  double _lastKmDistance = 0.0;

  late Run _run;
  late VoidCallback _onTick;

  RunTrackingService(this.ref);

  // 타이머 실행, 위치 2초마다 받아옴
  void start(Run run, {required VoidCallback onTick}) {
    _run = run;
    _onTick = onTick;

    _timer.start(_onTick);
    _tracker.startTracking(_handleLocation);
  }

  // 타이머, 위치 스트림 멈춤, 세그먼트 생성
  void pause() {
    _timer.stop();
    _tracker.stopTracking();
    _finalizeSegment();
  }

  void dispose() {
    _timer.stop();
    _tracker.stopTracking();
  }

  // 좌표 하나 받아와서 배열에 저장, 누적거리 1km 넘으면 메서드 호출
  void _handleLocation(Position pos) {
    final coord = RunCoordinate(
      lat: pos.latitude,
      lon: pos.longitude,
      recordedAt: DateTime.now(),
    );
    _currentCoords.add(coord);
    print("📍 위치 수신됨: ${coord.toJson()}");
    _totalDistance += 0.01;
    // TODO: 정확한 거리 계산
    // if (_currentCoords.length > 1) {
    //   final a = _currentCoords[_currentCoords.length - 2];
    //   final b = _currentCoords.last;
    //   final delta = Geolocator.distanceBetween(a.lat, a.lon, b.lat, b.lon);
    //   _totalDistance += delta;
    // }

    if (_totalDistance - _lastKmDistance >= 1.0) {
      _finalizeSegment();
      _lastKmDistance = _totalDistance;

      final nowPace = _calculatePace(_run.time);
      final prev = ref.read(runSectionProvider).last;
      final variation = _calcVariation(prev?.pace, nowPace);


      final section = RunSection(
      kilometer: _lastKmDistance,
      pace: nowPace,
      variation: variation,
      coordinates: List.from(_currentCoords),
    );
      ref.read(runSectionProvider.notifier).add(section);
      print("📍 섹션 렌더링: ${section.kilometer}, ${section.pace}, ${section.variation}");
      _currentCoords.clear();
    }
  }

  // 배열로 세그먼트 만들고 저장, 1km / 일시정지 할 때 호출
  void _finalizeSegment() {
    if (_currentCoords.length < 2) return;
    final segment = RunSegmentHelper.createSegment(_currentCoords);
    _segments.add(segment);
    print("🟨 세그먼트 생성됨: ${segment.toJson()}");
    _currentCoords.clear();
  }

  // 지금까지 만든 러닝 결과 객체 만들어 리턴
  RunResult buildFinalResult({
    required Run run,
    String? memo,
    RunningSurface? place,
    int? intensity,
  }) {
    if (_currentCoords.isNotEmpty) {
      _finalizeSegment();

      // ✅ [추가] 일시정지로 인한 마지막 구간도 생성해서 구간 목록에 추가
      final nowPace = _calculatePace(run.time);
      final prev = ref.read(runSectionProvider).last;
      final variation = _calcVariation(prev?.pace, nowPace);

      final section = RunSection(
        kilometer: _lastKmDistance,
        pace: nowPace,
        variation: variation,
        coordinates: List.from(_currentCoords),
      );

      ref.read(runSectionProvider.notifier).add(section);
      print("🟨 정지 시 RunSection 추가됨: ${section.kilometer}, ${section.pace}, ${section.variation}");
    }

    final result = RunResultBuilder.build(
      segments: _segments,
      title: _generateTitle(run.createdAt),
      userId: run.userId,
      createdAt: run.createdAt,
      memo: memo,
      place: place,
      intensity: intensity,
    );

    print("✅ 최종 RunResult JSON:\n${result.toJson()}");
    return result;
  }

  // 평균 페이스 게산
  String _calculatePace(int seconds) {
    if (_totalDistance == 0) return "0:00";
    final paceSec = seconds ~/ _totalDistance;
    return "${paceSec ~/ 60}:${(paceSec % 60).toString().padLeft(2, '0')}";
  }

  // 구간 간 변화량 계산
  int _calcVariation(String? prev, String now) {
    if (prev == null) return 0;
    final p = prev.split(":").map(int.parse).toList();
    final n = now.split(":").map(int.parse).toList();
    return (n[0] * 60 + n[1]) - (p[0] * 60 + p[1]);
  }

  // 제목 자동 생성
  String _generateTitle(DateTime date) {
    final weekday = ["월", "화", "수", "목", "금", "토", "일"][date.weekday - 1];
    final ampm = date.hour < 12 ? "오전" : "오후";
    return "$weekday $ampm 러닝";
  }
}

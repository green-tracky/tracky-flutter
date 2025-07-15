import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_location_tracker.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_result_builder.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_segment_helper.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_timer.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page_vm.dart';
import 'package:tracky_flutter/utils/run_state_utils.dart';

class RunTrackingService {
  final Ref ref;
  final RunTimer _timer = RunTimer();
  final LocationTracker _tracker = LocationTracker();

  final List<RunCoordinate> _currentCoords = [];
  final List<RunSegment> _segments = [];
  final List<RunRealtimeStat> _realtimeStats = [];

  double _totalDistance = 0.0;
  double _lastKmDistance = 0.0;

  double get totalDistance => _totalDistance;
  double get lastKmDistance => _lastKmDistance;
  List<RunRealtimeStat> get realtimeStats => List.unmodifiable(_realtimeStats);
  RunSegment? finalizeSegment() => _finalizeSegment();

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
    print("✅ pause() 호출됨 | 현재 좌표 수: ${_currentCoords.length}");

    final segment = _finalizeSegment();
    print("✅ segment: $segment");

    if (segment != null) {
      final nowPace = _calculatePace(_run.time);

      final prev = ref.read(runSectionProvider);
      final prevSection = prev.isNotEmpty ? prev.last : null;

      final variation = _calcVariation(prevSection?.pace, nowPace);

      final section = RunSection(
        kilometer: _lastKmDistance,
        pace: nowPace,
        variation: variation,
        coordinates: segment.coordinates,
      );

      print(
        "✅ RunSection 생성됨: ${section.kilometer}, ${section.pace}, ${section.variation}, 좌표 수: ${section.coordinates.length}",
      );

      ref.read(runSectionProvider.notifier).add(section);
      final all = ref.read(runSectionProvider);
      print("📌 현재 세션 총 개수: ${all.length}");
      print("✅ RunSectionProvider에 세션 추가 완료");
    }
  }

  void dispose() {
    _timer.stop();
    _tracker.stopTracking();
  }

  void reset() {
    print('🧹 [RunTrackingService] reset 호출 - 초기화 시작');
    _segments.clear();
    _currentCoords.clear();
    _realtimeStats.clear();
    _totalDistance = 0.0;
    _lastKmDistance = 0.0;
    dispose();
  }

  // 좌표 하나 받아와서 배열에 저장, 누적거리 1km 넘으면 메서드 호출
  void _handleLocation(Position pos) {
    final coord = RunCoordinate(
      lat: pos.latitude,
      lon: pos.longitude,
      recordedAt: DateTime.now(),
    );

    print("📍 위치 수신됨: ${coord.toJson()}");

    // 실시간 통계 계산
    if (_currentCoords.isNotEmpty) {
      final prev = _currentCoords.last;
      final weightKg = 65.0;

      final result = RunStatUtils.processRunningSegment(
        lat1: prev.lat,
        lon1: prev.lon,
        lat2: coord.lat,
        lon2: coord.lon,
        weightKg: weightKg,
      );

      final distanceKm = result['distance_m'] / 1000;
      final paceSec = distanceKm == 0 ? 0.0 : 2 / distanceKm;

      _realtimeStats.add(
        RunRealtimeStat(
          paceSec: paceSec,
          calories: result['calories_kcal'],
        ),
      );

      print("🔥 실시간 pace: ${paceSec.toStringAsFixed(1)} sec/km | kcal: ${result['calories_kcal']}");
    }

    _currentCoords.add(coord);
    print("📍 현재 좌표 수: ${_currentCoords.length}");

    if (_currentCoords.length >= 2) {
      final prev = _currentCoords[_currentCoords.length - 2];
      final curr = _currentCoords.last;
      final meters = RunStatUtils.calculateDistance(
        prev.lat,
        prev.lon,
        curr.lat,
        curr.lon,
      );
      _totalDistance += meters / 1000.0; // km 단위 누적
    }

    if (_totalDistance - _lastKmDistance >= 1.0) {
      _finalizeSegment();
      _lastKmDistance = _totalDistance;

      final sections = ref.read(runSectionProvider);
      final prev = sections.isNotEmpty ? sections.last : null;
      final nowPace = _calculatePace(_run.time);
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
  RunSegment? _finalizeSegment() {
    if (_currentCoords.length < 2) return null;

    final segment = RunSegmentHelper.createSegment(_currentCoords);
    _segments.add(segment);
    print("📍 세그먼트 생성됨: ${segment.toJson()}");

    _currentCoords.clear();
    return segment;
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

      final nowPace = _calculatePace(run.time);
      final sectionList = ref.read(runSectionProvider);
      final prev = sectionList.isNotEmpty ? sectionList.last : null;

      final variation = _calcVariation(prev?.pace, nowPace);

      final section = RunSection(
        kilometer: _lastKmDistance,
        pace: nowPace,
        variation: variation,
        coordinates: List.from(_currentCoords),
      );

      ref.read(runSectionProvider.notifier).add(section);
      print("📍 정지 시 RunSection 추가됨: ${section.kilometer}, ${section.pace}, ${section.variation}");
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

    print("📍 최종 RunResult JSON:\n${result.toJson()}");
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
    final weekday = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"][date.weekday - 1];
    final ampm = date.hour < 12 ? "오전" : "오후";
    return "$weekday $ampm 러닝";
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_tracking_service.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page_vm.dart';

final runRepositoryProvider = Provider<RunRepository>((ref) => RunRepository());

final runRunningProvider = StateNotifierProvider.autoDispose<RunRunningVM, AsyncValue<Run>>((ref) {
  return RunRunningVM(repository: ref.read(runRepositoryProvider), ref: ref);
});

class RunRunningVM extends StateNotifier<AsyncValue<Run>> {
  final RunRepository repository;
  final Ref ref;
  final RunTrackingService _trackingService;

  RunRealtimeStat? _lastStat;
  RunRealtimeStat? get lastStat => _lastStat;

  RunRunningVM({required this.repository, required this.ref})
    : _trackingService = RunTrackingService(ref),
      super(const AsyncLoading());

  // 화면 진입 시 호출
  Future<void> initRun(int id) async {
    state = const AsyncLoading();
    try {
      final run = await repository.getOneRun(id);
      state = AsyncData(run);

      if (run.isRunning) {
        _trackingService.start(run, onTick: _onTick);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // 러닝 시작 / 정지 토글
  void setIsRunning(bool running) {
    state.whenData((run) {
      final updated = run.copyWith(isRunning: running);
      state = AsyncData(updated);
      repository.updateRun(updated);

      if (running) {
        _trackingService.start(updated, onTick: _onTick);
      } else {
        _trackingService.pause();
      }
    });
  }

  // 일시정지 버튼 누를 때 호출
  void pause() {
    _trackingService.pause(); // 내부적으로 세그먼트 생성됨

    final segment = _trackingService.finalizeSegment();
    print("✅ segment: $segment");

    if (segment != null) {
      final nowPace = _calculatePace(state.value!.time);
      final prev = ref.read(runSectionProvider);
      final prevSection = prev.isNotEmpty ? prev.last : null;
      final variation = _calcVariation(prevSection?.pace, nowPace);

      final section = RunSection(
        kilometer: _trackingService.lastKmDistance,
        pace: nowPace,
        variation: variation,
        coordinates: segment.coordinates,
      );

      print(
        "✅ RunSection 생성됨: ${section.kilometer}, ${section.pace}, ${section.variation}, 좌표 수: ${section.coordinates.length}",
      );
      ref.read(runSectionProvider.notifier).add(section);
      print("✅ RunSectionProvider에 섹션 추가 완료");
    }
  }

  // ⏱️ 타이머 콜백 (1초마다 호출)
  void _onTick() {
    state.whenData((run) {
      if (!run.isRunning) return;
      final updated = run.copyWith(time: run.time + 1);
      state = AsyncData(updated);

      final stats = _trackingService.realtimeStats;
      if (stats.isNotEmpty) {
        _lastStat = stats.last;
      }
    });
  }

  // 최종 러닝 결과 저장
  Future<void> finalizeRun() async {
    final run = state.value!;
    final result = _trackingService.buildFinalResult(run: run);
    await repository.saveRun(result);
  }

  // 실시간 속도, 칼로리 목록
  List<RunRealtimeStat> getRealtimeStats() {
    return _trackingService.realtimeStats;
  }

  // 구간 페이스 계산 (구간용 텍스트)
  String _calculatePace(int seconds) {
    if (_trackingService.lastKmDistance == 0) return "0:00";
    final paceSec = seconds ~/ _trackingService.lastKmDistance;
    return "${paceSec ~/ 60}:${(paceSec % 60).toString().padLeft(2, '0')}";
  }

  // 구간 간 변화량 계산
  int _calcVariation(String? prev, String now) {
    if (prev == null) return 0;
    final p = prev.split(":").map(int.parse).toList();
    final n = now.split(":").map(int.parse).toList();
    return (n[0] * 60 + n[1]) - (p[0] * 60 + p[1]);
  }

  @override
  void dispose() {
    _trackingService.dispose();
    super.dispose();
  }
}

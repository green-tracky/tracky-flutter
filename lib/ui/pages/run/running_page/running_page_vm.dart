import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/dio.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_tracking_service.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page_vm.dart';

final runRepositoryProvider = Provider<RunRepository>((ref) => RunRepository());

final runRunningProvider = StateNotifierProvider.autoDispose<RunRunningVM, AsyncValue<Run>>((ref) {
  print('💡 [runRunningProvider] 새로 생성!');
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
      super(const AsyncLoading()) {
    print('🚀 [RunRunningVM] 생성자 호출 - 초기 상태: $state');
  }

  // 새 러닝 시작 (0부터 초기화)
  Future<void> startNewRun(int userId) async {
    print('🟢 [RunRunningVM] startNewRun 시작');
    _trackingService.reset();
    print('   [RunRunningVM] _trackingService.reset() 호출 후');
    final newRun = Run(
      distance: 0.0,
      time: 0,
      isRunning: true,
      createdAt: DateTime.now(),
      userId: userId,
    );
    state = AsyncData(newRun);
    print('   [RunRunningVM] state 초기화: $state');
    _trackingService.start(newRun, onTick: _onTick);
    print('🟢 [RunRunningVM] startNewRun 완료');
  }

  // 기존 러닝 재개 (더미 or 서버 저장된 데이터 로딩)
  Future<void> loadExistingRun(int id) async {
    print('🔵 [RunRunningVM] loadExistingRun 시작: $id');
    state = const AsyncLoading();
    try {
      final run = await repository.getOneRun(id);
      print('   [RunRunningVM] 서버에서 run 받아옴: $run');
      state = AsyncData(run);

      if (run.isRunning) {
        _trackingService.start(run, onTick: _onTick);
      }
    } catch (e, st) {
      print('   [RunRunningVM] 에러 발생: $e');
      state = AsyncError(e, st);
    }
  }

  // 러닝 상태 토글
  void setIsRunning(bool running) {
    print('🟡 [RunRunningVM] setIsRunning: $running');
    state.whenData((run) {
      final updated = run.copyWith(isRunning: running);
      state = AsyncData(updated);
      print('   [RunRunningVM] 상태 변경: $updated');
      repository.updateRun(updated);

      if (running) {
        _trackingService.start(updated, onTick: _onTick);
      } else {
        _trackingService.pause();
      }
    });
  }

  // 일시정지
  void pause() {
    print('🛑 [RunRunningVM] pause() 호출');
    _trackingService.pause();

    final segment = _trackingService.finalizeSegment();
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

      ref.read(runSectionProvider.notifier).add(section);
      print('   [RunRunningVM] pause: 새로운 section 추가됨');
    }
  }

  // 1초마다 호출
  void _onTick() {
    state.whenData((run) {
      if (!run.isRunning) return;
      final updated = run.copyWith(time: run.time + 1, distance: _trackingService.totalDistance,);
      state = AsyncData(updated);
      print('⏱️ [RunRunningVM] _onTick: 시간 증가, 현재 상태: $updated');

      final stats = _trackingService.realtimeStats;
      if (stats.isNotEmpty) {
        _lastStat = stats.last;
        print('   [RunRunningVM] _onTick: stats 갱신: $_lastStat');
      }
    });
  }

  // 최종 결과 저장
  Future<RunResult> finalizeRun() async {
    print('🏁 [RunRunningVM] finalizeRun() 호출');
    final run = state.value!;
    final result = _trackingService.buildFinalResult(run: run);
    await repository.saveRun(result);
    print('🏁 [RunRunningVM] 결과 저장 완료');
    return result;
  }

  // 실시간 통계
  List<RunRealtimeStat> getRealtimeStats() {
    print('📊 [RunRunningVM] getRealtimeStats 호출');
    return _trackingService.realtimeStats;
  }

  // 페이스 계산
  String _calculatePace(int seconds) {
    if (_trackingService.lastKmDistance == 0) return "0:00";
    final paceSec = seconds ~/ _trackingService.lastKmDistance;
    return "${paceSec ~/ 60}:${(paceSec % 60).toString().padLeft(2, '0')}";
  }

  // 구간 간 페이스 변화량
  int _calcVariation(String? prev, String now) {
    if (prev == null) return 0;
    final p = prev.split(":").map(int.parse).toList();
    final n = now.split(":").map(int.parse).toList();
    return (n[0] * 60 + n[1]) - (p[0] * 60 + p[1]);
  }

  @override
  void dispose() {
    print('❌ [RunRunningVM] dispose 호출!');
    _trackingService.dispose();
    super.dispose();
  }
}

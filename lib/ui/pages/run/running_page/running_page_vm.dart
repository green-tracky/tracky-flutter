import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/logic/run_tracking_service.dart';

final runRepositoryProvider = Provider<RunRepository>((ref) => RunRepository());

final runRunningProvider = StateNotifierProvider.autoDispose<RunRunningVM, AsyncValue<Run>>((ref) {
  return RunRunningVM(repository: ref.read(runRepositoryProvider), ref: ref);
});

class RunRunningVM extends StateNotifier<AsyncValue<Run>> {
  final RunRepository repository;
  final Ref ref;
  final RunTrackingService _trackingService;

  RunRunningVM({required this.repository, required this.ref})
      : _trackingService = RunTrackingService(ref),
        super(const AsyncLoading());

  // 화면 진입
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

  // 러닝 시작 정지
  void setIsRunning(bool running) {
    state.whenData((run) {
      final updated = run.copyWith(isRunning: running);
      state = AsyncData(updated);
      repository.updateRun(updated);

      if (running) {
        _trackingService.start(run, onTick: _onTick);
      } else {
        _trackingService.pause();
      }
    });
  }

  // 타이머 카운트
  void _onTick() {
    state.whenData((run) {
      if (!run.isRunning) return;
      final updated = run.copyWith(time: run.time + 1);
      state = AsyncData(updated);
    });
  }

  // 결과 저장
  Future<void> finalizeRun() async {
    final run = state.value!;
    final result = _trackingService.buildFinalResult(
      run: run,
    );
    await repository.saveRun(result); // 여기서 RunResult 저장
  }

  @override
  void dispose() {
    _trackingService.dispose();
    super.dispose();
  }
}

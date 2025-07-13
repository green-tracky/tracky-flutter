// lib/ui/pages/run/detail_page/detail_page_vm.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';
import '../../../../data/model/Run.dart';

/// RunDetail 전용 Repository Provider
final runDetailRepositoryProvider = Provider<RunDetailRepository>((ref) {
  return RunDetailRepository.instance;
});

/// VM: AsyncNotifier 기반, RunId에 따른 상세 정보
class RunDetailVM extends FamilyAsyncNotifier<RunResult, int> {
  late final RunDetailRepository _repo;

  @override
  Future<RunResult> build(int runId) {
    _repo = ref.read(runDetailRepositoryProvider);
    return _repo.getOneRun(runId);
  }

  /// 제목 업데이트 (로컬 캐시 + 서버 요청)
  Future<void> updateTitle(int runId, String newTitle) async {
    state = state.whenData((r) => r.copyWith(title: newTitle));
    await _repo.patchRunTitle(runId, newTitle);
  }

  /// 초기 데이터 강제 세팅 (로컬 데이터 렌더링용)
  void setInitial(RunResult result) {
    state = AsyncData(result);
  }

  /// 서버로부터 다시 fetch
  Future<void> fetchFromServer(int runId) async {
    state = const AsyncLoading();
    state = AsyncData(await _repo.getOneRun(runId));
  }
}

/// Provider 연결
final runDetailProvider =
AsyncNotifierProvider.family<RunDetailVM, RunResult, int>(RunDetailVM.new);

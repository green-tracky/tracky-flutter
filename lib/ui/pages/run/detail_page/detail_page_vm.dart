// lib/ui/pages/run/detail_page/detail_page_vm.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

import '../../../../data/model/Run.dart';

/// 1) RunDetail 전용 Repository Provider
final runDetailRepositoryProvider = Provider<RunDetailRepository>((ref) {
  return RunDetailRepository.instance;
});

/// 2) AsyncNotifier 기반 VM → build(int) 오버라이드 가능
class RunDetailVM extends FamilyAsyncNotifier<RunResult, int> {
  late final RunDetailRepository _repo;

  @override
  Future<RunResult> build(int runId) {
    _repo = ref.read(runDetailRepositoryProvider);
    return _repo.getOneRun(runId);
  }

  /// 제목만 업데이트 (로컬 캐시 + 서버 PATCH)
  Future<void> updateTitle(int runId, String newTitle) async {
    // 1) 로컬 캐시 업데이트
    state = state.whenData((r) => r.copyWith(title: newTitle));
    // 2) 서버에 PATCH 요청
    await _repo.patchRunTitle(runId, newTitle);
  }
}

/// 3) RunDetailPage에서 사용할 Provider
final runDetailProvider = AsyncNotifierProvider.family<RunDetailVM, RunResult, int>(RunDetailVM.new);

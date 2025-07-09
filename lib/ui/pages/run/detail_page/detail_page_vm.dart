import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

/// RunDetail용 전용 Provider
final runDetailRepositoryProvider = Provider<RunDetailRepository>((ref) {
  return RunDetailRepository.instance;
});

final runDetailProvider = FutureProvider.family<RunResult, int>((ref, id) async {
  final repo = ref.watch(runDetailRepositoryProvider);
  return await repo.getOneRun(id);
});

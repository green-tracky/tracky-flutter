import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Run.dart';

final runSectionProvider = StateNotifierProvider<RunSectionVM, List<RunSection>>(
  (ref) => RunSectionVM(),
);

class RunSectionVM extends StateNotifier<List<RunSection>> {
  RunSectionVM() : super([]);

  void add(RunSection section) {
    state = [...state, section];
  }

  void clear() {
    state = [];
  }

  RunSection? get last => state.isNotEmpty ? state.last : null;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/main.dart';

final runningBadgeProvider = AutoDisposeNotifierProvider<RunningBadgeVM, RunningBadgeModel?>(() {
  return RunningBadgeVM();
});

class RunningBadgeVM extends AutoDisposeNotifier<RunningBadgeModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  RunningBadgeModel? build() {
    return null;
  }
}

class RunningBadgeModel {
  RunningBadgeModel();

  RunningBadgeModel.fromMap(Map<String, dynamic> data);

  RunningBadgeModel copyWith() {
    return this;
  }
}
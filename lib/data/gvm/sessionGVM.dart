import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/main.dart';

final sessionProvider = AutoDisposeNotifierProvider<SessionGVM, SessionModel?>(() {
  return SessionGVM();
});

class SessionGVM extends AutoDisposeNotifier<SessionModel?> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel? build() {
    return null;
  }
}

class SessionModel {
  SessionModel();

  SessionModel.fromMap(Map<String, dynamic> data);

  SessionModel copyWith() {
    return this;
  }
}
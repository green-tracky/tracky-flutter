import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RunGoalType { distance, time, speed }

final runGoalTypeProvider = StateProvider<RunGoalType?>((ref) => null);
final runGoalValueProvider = StateProvider<double?>((ref) => null);
final runDistanceProvider = StateProvider<double>((ref) => 0.0); // 거리 계산

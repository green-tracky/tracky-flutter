import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RunGoalType { distance, time, speed }

final runGoalTypeProvider = StateProvider<RunGoalType?>((ref) => null);
final runGoalValueProvider = StateProvider<double?>((ref) => null);

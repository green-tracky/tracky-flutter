import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/data/model/Run.dart';

enum RunGoalType { distance, time, speed }

final runGoalTypeProvider = StateProvider<RunGoalType?>((ref) => null);
final runGoalValueProvider = StateProvider<double?>((ref) => null);
final runDistanceProvider = StateProvider<double>((ref) => 0.0); // 거리 계산

final currentPositionProvider = StateProvider<LatLng?>((ref) => null);
final runResultStateProvider = StateProvider<RunResult?>((ref) => null);

final runIntensityProvider = StateProvider<int?>((ref) => null);
final runningSurfaceProvider = StateProvider<RunningSurface?>((ref) => null);
final runMemoProvider = StateProvider<String?>((ref) => null);
final runResultProvider = StateProvider<RunResult?>((ref) => null); // 일시정지 눌렀을 때 받아오는 값

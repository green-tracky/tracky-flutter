import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/activity.dart';

final runningSurfaceProvider = StateProvider<RunningSurface?>(
  (ref) => null,
); // 러닝 장소
final runMemoProvider = StateProvider<String>((ref) => ''); // 메모
final runIntensityProvider = StateProvider<int?>((ref) => null); // 러닝 강도
final runResultProvider = StateProvider<RunResult?>(
  (ref) => null,
); // 일시정지 눌렀을 때 받아오는 값

import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/utils/run_state_utils.dart';

class RunSegmentHelper {
  static RunSegment createSegment(List<RunCoordinate> coords) {
    if (coords.length < 2) {
      throw ArgumentError('최소 2개의 좌표가 필요합니다');
    }

    final start = coords.first.recordedAt;
    final end = coords.last.recordedAt;
    final duration = end.difference(start).inSeconds;

    final distance = RunStatUtils.totalDistance(coords);
    final paceSec = distance == 0 ? 0 : (duration / (distance / 1000)).round();

    return RunSegment(
      startDate: start,
      endDate: end,
      durationSeconds: duration,
      distanceMeters: distance,
      pace: paceSec,
      coordinates: List.from(coords),
    );
  }
}

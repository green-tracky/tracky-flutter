// 더미 구간 데이터 모델

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'activity.dart';

class RunSection {
  final double kilometer;
  final String pace;
  final int variation;

  RunSection({required this.kilometer, required this.pace, required this.variation});
}

// lib/data/model/run_pause.dart
class Run {
  final double distance;
  final int time;
  final String? place;
  final int? intensity;
  final String? memo;
  final DateTime createdAt;
  final int userId;

  Run({
    required this.distance,
    required this.time,
    this.place,
    this.intensity,
    this.memo,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'distance': distance,
    'time': time,
    'place': place,
    'intensity': intensity,
    'memo': memo,
    'createdAt': createdAt.toIso8601String(),
    'userId': userId,
  };
}

class RunCoordinate {
  final double lat;
  final double lon;
  final DateTime recordedAt;

  RunCoordinate({
    required this.lat,
    required this.lon,
    required this.recordedAt,
  });

  factory RunCoordinate.fromJson(Map<String, dynamic> json) {
    return RunCoordinate(
      lat: json['lat'],
      lon: json['lon'],
      recordedAt: DateTime.parse(json['recordedAt']),
    );
  }

  LatLng toLatLng() => LatLng(lat, lon);
}

class RunSegment {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final int durationSeconds;
  final int distanceMeters;
  final int pace;
  final List<RunCoordinate> coordinates;

  RunSegment({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.durationSeconds,
    required this.distanceMeters,
    required this.pace,
    required this.coordinates,
  });

  factory RunSegment.fromJson(Map<String, dynamic> json) {
    return RunSegment(
      id: json['id'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      durationSeconds: json['durationSeconds'],
      distanceMeters: json['distanceMeters'],
      pace: json['pace'],
      coordinates: (json['coordinates'] as List).map((e) => RunCoordinate.fromJson(e)).toList(),
    );
  }

  List<LatLng> get latLngs => coordinates.map((e) => e.toLatLng()).toList();
}

class RunResult {
  final int id;
  final String title;
  final String memo;
  final int calories;
  final int totalDistanceMeters;
  final int totalDurationSeconds;
  final int elapsedTimeInSeconds;
  final int avgPace;
  final int bestPace;
  final int userId;
  final List<RunSegment> segments;
  final DateTime createdAt;
  final int? intensity;
  final String? memoNote;
  final RunningSurface? place;

  RunResult({
    required this.id,
    required this.title,
    required this.memo,
    required this.calories,
    required this.totalDistanceMeters,
    required this.totalDurationSeconds,
    required this.elapsedTimeInSeconds,
    required this.avgPace,
    required this.bestPace,
    required this.userId,
    required this.segments,
    required this.createdAt,
    this.intensity,
    this.memoNote,
    this.place,
  });

  factory RunResult.fromJson(Map<String, dynamic> json) {
    return RunResult(
      id: json['id'],
      title: json['title'],
      memo: json['memo'],
      calories: json['calories'],
      totalDistanceMeters: json['totalDistanceMeters'],
      totalDurationSeconds: json['totalDurationSeconds'],
      elapsedTimeInSeconds: json['elapsedTimeInSeconds'],
      avgPace: json['avgPace'],
      bestPace: json['bestPace'],
      userId: json['userId'],
      segments: (json['segments'] as List).map((e) => RunSegment.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      intensity: json['intensity'],
      memoNote: json['memo'], // 서버 구조 바뀌면 변경
      place: json['place'] == null ? null : getSurfaceFromLabel(json['place']),
    );
  }

  // 전체 경로 (지도용)
  List<List<LatLng>> get paths => segments.map((s) => s.latLngs).toList();
}

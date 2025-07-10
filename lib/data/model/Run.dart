import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/data/model/activity.dart';

/// 러닝 중 상태 모델
class Run {
  final double distance;
  final int time;
  final bool isRunning;
  final DateTime createdAt;
  final int userId;

  Run({
    required this.distance,
    required this.time,
    required this.isRunning,
    required this.createdAt,
    required this.userId,
  });

  Run copyWith({
    double? distance,
    int? time,
    bool? isRunning,
    DateTime? createdAt,
    int? userId,
  }) {
    return Run(
      distance: distance ?? this.distance,
      time: time ?? this.time,
      isRunning: isRunning ?? this.isRunning,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() => {
    'distance': distance,
    'time': time,
    'isRunning': isRunning,
    'createdAt': createdAt.toIso8601String(),
    'userId': userId,
  };
}

/// GPS 좌표 모델
class RunCoordinate {
  final int? id;
  final double lat;
  final double lon;
  final DateTime recordedAt;

  RunCoordinate({
    this.id,
    required this.lat,
    required this.lon,
    required this.recordedAt,
  });

  LatLng toLatLng() => LatLng(lat, lon);

  factory RunCoordinate.fromJson(Map<String, dynamic> json) {
    return RunCoordinate(
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      recordedAt: DateTime.parse(json['recordedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'lat': lat,
    'lon': lon,
    'recordedAt': recordedAt.toIso8601String(),
  };
}

/// 구간별 거리/페이스/변화량 모델 (지도/표시용)
class RunSection {
  final double kilometer;
  final String pace;
  final int variation;
  final List<RunCoordinate> coordinates;

  RunSection({
    required this.kilometer,
    required this.pace,
    required this.variation,
    required this.coordinates,
  });
}

/// 실제 서버 전송 및 계산용 세그먼트
class RunSegment {
  final int? id;
  final DateTime startDate;
  final DateTime endDate;
  final int durationSeconds;
  final int distanceMeters;
  final int pace;
  final List<RunCoordinate> coordinates;

  RunSegment({
    this.id,
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
      coordinates: (json['coordinates'] as List)
          .map((e) => RunCoordinate.fromJson(e))
          .toList(),
    );
  }

  List<LatLng> get latLngs => coordinates.map((e) => e.toLatLng()).toList();

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'durationSeconds': durationSeconds,
    'distanceMeters': distanceMeters,
    'pace': pace,
    'coordinates': coordinates.map((c) => c.toJson()).toList(),
  };
}

/// 전체 러닝 결과 모델
class RunResult {
  final int id;
  final String title;
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
  final String? memo;
  final RunningSurface? place;

  RunResult({
    required this.id,
    required this.title,
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
    this.memo,
    this.place,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'calories': calories,
    'totalDistanceMeters': totalDistanceMeters,
    'totalDurationSeconds': totalDurationSeconds,
    'elapsedTimeInSeconds': elapsedTimeInSeconds,
    'avgPace': avgPace,
    'bestPace': bestPace,
    'userId': userId,
    'segments': segments.map((s) => s.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'intensity': intensity,
    'memo': memo,
    'place': place?.label,
  };

  factory RunResult.fromJson(Map<String, dynamic> json) {
    return RunResult(
      id: json['id'],
      title: json['title'],
      calories: json['calories'],
      totalDistanceMeters: json['totalDistanceMeters'],
      totalDurationSeconds: json['totalDurationSeconds'],
      elapsedTimeInSeconds: json['elapsedTimeInSeconds'],
      avgPace: json['avgPace'],
      bestPace: json['bestPace'],
      userId: json['userId'],
      segments: (json['segments'] as List)
          .map((e) => RunSegment.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      intensity: json['intensity'],
      memo: json['memo'],
      place: json['place'] == null ? null : getSurfaceFromLabel(json['place']),
    );
  }

  RunResult copyWith({
    int? id,
    String? title,
    int? calories,
    int? totalDistanceMeters,
    int? totalDurationSeconds,
    int? elapsedTimeInSeconds,
    int? avgPace,
    int? bestPace,
    int? userId,
    List<RunSegment>? segments,
    DateTime? createdAt,
    int? intensity,
    String? memo,
    RunningSurface? place,
  }) {
    return RunResult(
      id: id ?? this.id,
      title: title ?? this.title,
      calories: calories ?? this.calories,
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      elapsedTimeInSeconds: elapsedTimeInSeconds ?? this.elapsedTimeInSeconds,
      avgPace: avgPace ?? this.avgPace,
      bestPace: bestPace ?? this.bestPace,
      userId: userId ?? this.userId,
      segments: segments ?? this.segments,
      createdAt: createdAt ?? this.createdAt,
      intensity: intensity ?? this.intensity,
      memo: memo ?? this.memo,
      place: place ?? this.place,
    );
  }

  List<List<LatLng>> get paths => segments.map((s) => s.latLngs).toList();
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

class RunLevelVM extends AsyncNotifier<RunLevelResponse?> {
  @override
  Future<RunLevelResponse?> build() async {
    final response = await RunRepository().getRunLevelData(); // 실제 API 호출
    return RunLevelResponse.fromMap(response['data']);
  }
}

final runLevelProvider = AsyncNotifierProvider<RunLevelVM, RunLevelResponse?>(
  RunLevelVM.new,
);

class RunLevel {
  final int id;
  final String name;
  final int minDistance;
  final int maxDistance;
  final String description;
  final String imageUrl;
  final int sortOrder;
  final bool isCurrent;

  RunLevel({
    required this.id,
    required this.name,
    required this.minDistance,
    required this.maxDistance,
    required this.description,
    required this.imageUrl,
    required this.sortOrder,
    required this.isCurrent,
  });

  factory RunLevel.fromMap(Map<String, dynamic> map) {
    return RunLevel(
      id: map['id'],
      name: map['name'],
      minDistance: map['minDistance'],
      maxDistance: map['maxDistance'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      sortOrder: map['sortOrder'],
      isCurrent: map['isCurrent'],
    );
  }
}

class RunLevelResponse {
  final String currentLevel;
  final String nextLevelName;
  final int totalDistance; // 단위: meter
  final int distanceToNextLevel; // 단위: meter

  RunLevelResponse({
    required this.currentLevel,
    required this.nextLevelName,
    required this.totalDistance,
    required this.distanceToNextLevel,
  });

  factory RunLevelResponse.fromMap(Map<String, dynamic> map) {
    final runLevels = List<Map<String, dynamic>>.from(map['runLevels']);
    final currentLevel = runLevels.firstWhere((e) => e['isCurrent'] == true);
    final currentIndex = runLevels.indexOf(currentLevel);
    final nextLevel = currentIndex + 1 < runLevels.length ? runLevels[currentIndex + 1] : null;

    return RunLevelResponse(
      currentLevel: currentLevel['name'] ?? '',
      nextLevelName: nextLevel?['name'] ?? '최고 레벨',
      totalDistance: map['totalDistance'] ?? 0,
      distanceToNextLevel: map['distanceToNextLevel'] ?? 0,
    );
  }
}

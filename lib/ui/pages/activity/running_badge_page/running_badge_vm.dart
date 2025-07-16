import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';

final runningBadgeProvider = AutoDisposeAsyncNotifierProvider<RunningBadgeVM, RunningBadgeModel>(
  () => RunningBadgeVM(),
);

class RunningBadgeVM extends AutoDisposeAsyncNotifier<RunningBadgeModel> {
  @override
  Future<RunningBadgeModel> build() async {
    final json = await RunRepository().getRunningBadges();
    return RunningBadgeModel.fromMap(json);
  }
}

class RunningBadgeModel {
  final List<Map<String, dynamic>> recents; // ✅ 수정된 부분
  final List<Badge> bests;
  final List<Badge> monthly;
  final List<Badge> challenges;

  RunningBadgeModel({
    required this.recents,
    required this.bests,
    required this.monthly,
    required this.challenges,
  });

  factory RunningBadgeModel.fromMap(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return RunningBadgeModel(
      recents: (data['recents'] as List<dynamic>?)?.map((e) => Map<String, dynamic>.from(e)).toList() ?? [],
      bests: (data['bests'] as List<dynamic>?)?.map((e) => Badge.fromMap(e).copyWith(isMine: true)).toList() ?? [],
      monthly: (data['monthly'] as List<dynamic>?)?.map((e) => Badge.fromMap(e)).toList() ?? [],
      challenges: (data['challenges'] as List<dynamic>?)?.map((e) => Badge.fromMap(e)).toList() ?? [],
    );
  }
}

class Badge {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String type;
  final DateTime? achievedAt;
  final bool isAchieved;
  final int? achievedCount;
  final bool isMine;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.type,
    required this.achievedAt,
    required this.isAchieved,
    required this.achievedCount,
    this.isMine = false,
  });

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      type: map['type'],
      achievedAt: map['achievedAt'] != null ? DateTime.tryParse(map['achievedAt']) : null,
      isAchieved: map['isAchieved'] ?? false,
      achievedCount: map['achievedCount'],
    );
  }

  String? get formattedDate => achievedAt != null ? DateFormat('yyyy. MM. dd.').format(achievedAt!) : null;

  Badge copyWith({bool? isMine}) {
    return Badge(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      type: type,
      achievedAt: achievedAt,
      isAchieved: isAchieved,
      achievedCount: achievedCount,
      isMine: isMine ?? this.isMine,
    );
  }
}

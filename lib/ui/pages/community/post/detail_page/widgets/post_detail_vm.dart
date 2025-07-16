import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ✅ Provider 정의
final postDetailProvider = AsyncNotifierProviderFamily<PostDetailVM, PostDetailVMState, int>(
  PostDetailVM.new,
);

/// ✅ ViewModel
class PostDetailVM extends FamilyAsyncNotifier<PostDetailVMState, int> {
  final _repo = PostDetailRepository();

  @override
  Future<PostDetailVMState> build(int postId) async {
    final model = await _repo.fetchPostDetail(postId);
    return PostDetailVMState.fromModel(model);
  }
}

/// ✅ Repository
class PostDetailRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api-url.com',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<PostDetailModel> fetchPostDetail(int postId) async {
    final response = await _dio.get('/s/api/community/posts/$postId');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'];
      return PostDetailModel.fromMap(data);
    } else {
      throw Exception('게시글 상세 조회 실패: ${response.statusCode}');
    }
  }
}

/// ✅ 최종 ViewModel 상태
class PostDetailVMState {
  final int id;
  final String content;
  final String createdAt;
  final bool isLiked;
  final int likeCount;
  final int commentCount;
  final bool isOwner;
  final UserModel user;
  final RunRecordModel runRecord;
  final List<CommentModel> comments;

  PostDetailVMState({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
    required this.isOwner,
    required this.user,
    required this.runRecord,
    required this.comments,
  });

  factory PostDetailVMState.fromModel(PostDetailModel model) {
    return PostDetailVMState(
      id: model.id,
      content: model.content,
      createdAt: model.createdAt,
      isLiked: model.isLiked,
      likeCount: model.likeCount,
      commentCount: model.commentCount,
      isOwner: model.isOwner,
      user: model.user,
      runRecord: model.runRecord,
      comments: model.comments,
    );
  }
}

/// ✅ PostDetail Model
class PostDetailModel {
  final int id;
  final String content;
  final String createdAt;
  final bool isLiked;
  final int likeCount;
  final int commentCount;
  final bool isOwner;
  final UserModel user;
  final RunRecordModel runRecord;
  final List<CommentModel> comments;

  PostDetailModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
    required this.isOwner,
    required this.user,
    required this.runRecord,
    required this.comments,
  });

  factory PostDetailModel.fromMap(Map<String, dynamic> map) {
    return PostDetailModel(
      id: map['id'],
      content: map['content'],
      createdAt: map['createdAt'],
      isLiked: map['isLiked'],
      likeCount: map['likeCount'],
      commentCount: map['commentCount'],
      isOwner: map['isOwner'],
      user: UserModel.fromMap(map['user']),
      runRecord: RunRecordModel.fromMap(map['runRecord']),
      comments: (map['commentsInfo']['comments'] as List).map((e) => CommentModel.fromMap(e)).toList(),
    );
  }
}

/// ✅ User Model
class UserModel {
  final int id;
  final String username;
  final String profileUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.profileUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      profileUrl: map['profileUrl'],
    );
  }
}

/// ✅ Comment Model
class CommentModel {
  final int id;
  final int postId;
  final int userId;
  final String username;
  final String content;
  final int? parentId;
  final String createdAt;
  final String updatedAt;
  final List<CommentModel> children;

  // ✅ UI 전용 필드 (서버 X)
  final bool isRepliesExpanded;
  final bool isReplying;
  final int repliesPage;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.content,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.children,
    this.isRepliesExpanded = false,
    this.isReplying = false,
    this.repliesPage = 1,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      postId: map['postId'],
      userId: map['userId'],
      username: map['username'],
      content: map['content'],
      parentId: map['parentId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      children: (map['children'] as List? ?? []).map<CommentModel>((e) => CommentModel.fromMap(e)).toList(),
    );
  }

  CommentModel copyWith({
    int? id,
    int? postId,
    int? userId,
    String? username,
    String? content,
    int? parentId,
    String? createdAt,
    String? updatedAt,
    List<CommentModel>? children,
    bool? isRepliesExpanded,
    bool? isReplying,
    int? repliesPage,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      content: content ?? this.content,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      children: children ?? this.children,
      isRepliesExpanded: isRepliesExpanded ?? this.isRepliesExpanded,
      isReplying: isReplying ?? this.isReplying,
      repliesPage: repliesPage ?? this.repliesPage,
    );
  }

  factory CommentModel.empty() => CommentModel(
    id: 0,
    postId: 0,
    userId: 0,
    username: '',
    content: '',
    parentId: null,
    createdAt: '',
    updatedAt: '',
    children: [],
  );
}

/// ✅ RunRecord Model
class RunRecordModel {
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
  final List<SegmentModel> segments;
  final List<RunPictureModel> pictures;
  final String createdAt;
  final int intensity;
  final String place;

  RunRecordModel({
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
    required this.pictures,
    required this.createdAt,
    required this.intensity,
    required this.place,
  });

  factory RunRecordModel.fromMap(Map<String, dynamic> map) {
    return RunRecordModel(
      id: map['id'],
      title: map['title'],
      memo: map['memo'],
      calories: map['calories'],
      totalDistanceMeters: map['totalDistanceMeters'],
      totalDurationSeconds: map['totalDurationSeconds'],
      elapsedTimeInSeconds: map['elapsedTimeInSeconds'],
      avgPace: map['avgPace'],
      bestPace: map['bestPace'],
      userId: map['userId'],
      segments: (map['segments'] as List).map((e) => SegmentModel.fromMap(e)).toList(),
      pictures: (map['pictures'] as List).map((e) => RunPictureModel.fromMap(e)).toList(),
      createdAt: map['createdAt'],
      intensity: map['intensity'],
      place: map['place'],
    );
  }
}

class SegmentModel {
  final int id;
  final String startDate;
  final String endDate;
  final int durationSeconds;
  final int distanceMeters;
  final int pace;
  final List<LatLng> coordinates;

  SegmentModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.durationSeconds,
    required this.distanceMeters,
    required this.pace,
    required this.coordinates,
  });

  factory SegmentModel.fromMap(Map<String, dynamic> map) {
    return SegmentModel(
      id: map['id'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      durationSeconds: map['durationSeconds'],
      distanceMeters: map['distanceMeters'],
      pace: map['pace'],
      coordinates: (map['coordinates'] as List).map<LatLng>((e) => LatLng(e['lat'], e['lon'])).toList(),
    );
  }
}

class RunPictureModel {
  final String fileUrl;
  final double lat;
  final double lon;
  final String savedAt;

  RunPictureModel({
    required this.fileUrl,
    required this.lat,
    required this.lon,
    required this.savedAt,
  });

  factory RunPictureModel.fromMap(Map<String, dynamic> map) {
    return RunPictureModel(
      fileUrl: map['fileUrl'],
      lat: map['lat'].toDouble(),
      lon: map['lon'].toDouble(),
      savedAt: map['savedAt'],
    );
  }
}

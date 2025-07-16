import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailReplyNotifier extends StateNotifier<List<CommentModel>> {
  PostDetailReplyNotifier(int postId) : super(dummyPostDetail.comments);

  void addComment(String content, {int? parentId}) {
    // 실제 데이터 조작 없음 (더미)
  }

  void deleteComment(int commentId) {
    // 실제 데이터 조작 없음 (더미)
  }
}

// 모델 정의
class UserModel {
  final int id;
  final String username;
  final String profileUrl;
  UserModel({required this.id, required this.username, required this.profileUrl});
}

class CoordinateModel {
  final double lat;
  final double lon;
  final String recordedAt;
  CoordinateModel({required this.lat, required this.lon, required this.recordedAt});
}

class SegmentModel {
  final List<CoordinateModel> coordinates;
  SegmentModel({required this.coordinates});
}

class PictureModel {
  final String fileUrl;
  final double lat;
  final double lon;
  final String savedAt;
  PictureModel({required this.fileUrl, required this.lat, required this.lon, required this.savedAt});
}

class RunRecordModel {
  final int id;
  final String title;
  final List<SegmentModel> segments;
  final List<PictureModel> pictures;
  RunRecordModel({required this.id, required this.title, required this.segments, required this.pictures});
}

class CommentModel {
  final int id;
  final String username;
  final String content;
  final List<CommentModel> children;
  CommentModel({required this.id, required this.username, required this.content, required this.children});
}

class PostDetailModel {
  final int id;
  final UserModel user;
  final String content;
  final RunRecordModel runRecord;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool isOwner;
  final String createdAt;
  final List<CommentModel> comments;
  PostDetailModel({
    required this.id,
    required this.user,
    required this.content,
    required this.runRecord,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.isOwner,
    required this.createdAt,
    required this.comments,
  });
}

// 더미 데이터 생성
final dummyPostDetail = PostDetailModel(
  id: 1,
  user: UserModel(id: 1, username: 'ssar', profileUrl: 'http://example.com/profiles/ssar.jpg'),
  content: 'ssar의 러닝 기록을 공유합니다.',
  runRecord: RunRecordModel(
    id: 1,
    title: '부산 서면역 15번 출구 100m 러닝',
    segments: [
      SegmentModel(
        coordinates: [
          CoordinateModel(lat: 35.1579, lon: 129.0594, recordedAt: '2025-06-20 09:00:00'),
          CoordinateModel(lat: 35.1579, lon: 129.06053636, recordedAt: '2025-06-20 09:00:50'),
        ],
      ),
    ],
    pictures: [
      PictureModel(
        fileUrl: 'https://example.com/images/run1.jpg',
        lat: 37.5665,
        lon: 126.978,
        savedAt: '2025-07-01 08:30:00',
      ),
    ],
  ),
  likeCount: 1,
  commentCount: 27,
  isLiked: false,
  isOwner: true,
  createdAt: '2025-07-15 15:46:37',
  comments: [
    CommentModel(id: 22, username: 'cos', content: '감동적인 글이었습니다.', children: []),
    CommentModel(
      id: 21,
      username: 'ssar',
      content: '앞으로도 잘 부탁드려요.',
      children: [
        CommentModel(id: 26, username: 'cos', content: '앞으로 자주 뵈어요!', children: []),
        CommentModel(id: 27, username: 'love', content: '저도 기대하고 있겠습니다.', children: []),
      ],
    ),
  ],
);

// Provider 설정
final postDetailProvider = FutureProvider.family<PostDetailModel, int>((ref, postId) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return dummyPostDetail;
});

final postDetailReplyProvider = FutureProvider.family<List<CommentModel>, int>((ref, postId) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return dummyPostDetail.comments;
});

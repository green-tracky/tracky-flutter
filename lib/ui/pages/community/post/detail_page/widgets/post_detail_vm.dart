import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// ✅ Provider 정의
final postDetailProvider = AsyncNotifierProviderFamily<PostDetailVM, PostDetailState, int>(
  PostDetailVM.new,
);

/// ✅ ViewModel 정의
class PostDetailVM extends FamilyAsyncNotifier<PostDetailState, int> {
  final _repo = PostDetailRepository();

  @override
  Future<PostDetailState> build(int postId) async {
    final detail = await _repo.fetchPostDetail(postId);
    return detail;
  }
}

// ✅ Repository 정의
class PostDetailRepository {
  Future<PostDetailModel> fetchPostDetail(int postId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // 여기에 서버에서 내려온 JSON 구조 그대로 넣으면 됩니다.
    final Map<String, dynamic> dummyResponse = {
      "id": postId,
      "content": "ssar의 러닝 기록을 공유합니다.",
      "createdAt": "2025-07-13 17:59:17",
      "isLiked": false,
      "likeCount": 1,
      "commentCount": 3,
      "isOwner": true,
      "user": {
        "id": 1,
        "username": "ssar",
        "profileUrl": "http://example.com/profiles/ssar.jpg",
      },
      "runRecord": {
        "id": 1,
        "title": "부산 서면역 15번 출구 100m 러닝",
        "pictures": [
          {
            "fileUrl": "https://example.com/images/run1.jpg",
          },
        ],
        "segments": [
          {
            "coordinates": [
              {"lat": 35.159250, "lon": 129.060054},
              {"lat": 35.159031, "lon": 129.059938},
              {"lat": 35.158513, "lon": 129.059522},
              {"lat": 35.158421, "lon": 129.058747},
              {"lat": 35.158138, "lon": 129.058524},
              {"lat": 35.157912, "lon": 129.058302},
              {"lat": 35.157840, "lon": 129.057940},
              {"lat": 35.157820, "lon": 129.057191},
              {"lat": 35.157818, "lon": 129.056754},
              {"lat": 35.157631, "lon": 129.056623},
              {"lat": 35.157456, "lon": 129.056601},
              {"lat": 35.157462, "lon": 129.057148},
              {"lat": 35.156872, "lon": 129.057175},
              {"lat": 35.156337, "lon": 129.057173},
              {"lat": 35.155965, "lon": 129.057012},
              {"lat": 35.155971, "lon": 129.056599},
              {"lat": 35.156015, "lon": 129.056438},
              {"lat": 35.158002, "lon": 129.064046},
              {"lat": 35.157890, "lon": 129.064722},
              {"lat": 35.157870, "lon": 129.065122},
              {"lat": 35.158590, "lon": 129.065191},
              {"lat": 35.159370, "lon": 129.065167},
              {"lat": 35.160482, "lon": 129.065159},
              {"lat": 35.160787, "lon": 129.064387},
              {"lat": 35.161105, "lon": 129.063587},
              {"lat": 35.161206, "lon": 129.063276},
              {"lat": 35.161429, "lon": 129.063475},
            ],
          },
        ],
      },
      "commentsInfo": {
        "comments": [
          {
            "id": 1,
            "username": "cos",
            "content": "좋아요!",
            "createdAt": "2025-07-13 17:59:17",
            "children": [
              {
                "id": 2,
                "username": "love",
                "content": "정말요!",
                "createdAt": "2025-07-13 17:59:17",
              },
            ],
          },
        ],
      },
    };

    return PostDetailModel.fromMap(dummyResponse);
  }
}

// model
class PostDetailState {
  final int postId;
  final String author;
  final String content;
  final String createdAt;
  final List<String> imageUrls;
  final int likeCount;
  final bool isLiked;
  final int commentCount;
  final List<Comment> comments;
  final List<List<LatLng>> paths;

  PostDetailState({
    required this.postId,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.imageUrls,
    required this.likeCount,
    required this.isLiked,
    required this.commentCount,
    required this.comments,
    required this.paths,
  });
}

class PostDetailModel {
  final int id;
  final String content;
  final String createdAt;
  final bool isLiked;
  final int likeCount;
  final int commentCount;
  final bool isOwner;
  final UserModel user;
  final List<String> imageUrls;
  final List<LatLng> coordinates;
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
    required this.imageUrls,
    required this.coordinates,
    required this.comments,
  });

  factory PostDetailModel.fromMap(Map<String, dynamic> map) {
    final List coords = map['runRecord']['segments'][0]['coordinates'];
    final List pics = map['runRecord']['pictures'];

    return PostDetailModel(
      id: map['id'],
      content: map['content'],
      createdAt: map['createdAt'],
      isLiked: map['isLiked'],
      likeCount: map['likeCount'],
      commentCount: map['commentCount'],
      isOwner: map['isOwner'],
      user: UserModel.fromMap(map['user']),
      imageUrls: pics.map<String>((e) => e['fileUrl'] as String).toList(),
      coordinates: coords.map<LatLng>((e) => LatLng(e['lat'], e['lon'])).toList(),
      comments: (map['commentsInfo']['comments'] as List).map<CommentModel>((e) => CommentModel.fromMap(e)).toList(),
    );
  }
}

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

class CommentModel {
  final int id;
  final String username;
  final String content;
  final String createdAt;
  final List<CommentModel> children;

  CommentModel({
    required this.id,
    required this.username,
    required this.content,
    required this.createdAt,
    required this.children,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      username: map['username'],
      content: map['content'],
      createdAt: map['createdAt'],
      children: (map['children'] as List? ?? []).map<CommentModel>((e) => CommentModel.fromMap(e)).toList(),
    );
  }
}

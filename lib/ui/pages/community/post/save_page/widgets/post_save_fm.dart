// ✅ post_save_fm.dart (State + VM + Repository 한 파일)

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider 정의
final postSaveProvider = AsyncNotifierProviderFamily<PostSaveVM, PostSaveState, int?>(
  PostSaveVM.new,
);

// State 정의
class PostSaveState {
  final String content;
  final int? runRecordId;
  final List<int> pictureIds;
  final List<RunRecordOption> runRecordOptions;

  PostSaveState({
    required this.content,
    required this.runRecordId,
    required this.pictureIds,
    required this.runRecordOptions,
  });

  PostSaveState copyWith({
    String? content,
    int? runRecordId,
    List<int>? pictureIds,
    List<RunRecordOption>? runRecordOptions,
  }) {
    return PostSaveState(
      content: content ?? this.content,
      runRecordId: runRecordId ?? this.runRecordId,
      pictureIds: pictureIds ?? this.pictureIds,
      runRecordOptions: runRecordOptions ?? this.runRecordOptions,
    );
  }
}

// VM 정의
class PostSaveVM extends FamilyAsyncNotifier<PostSaveState, int?> {
  final _repo = PostSaveRepository();

  @override
  Future<PostSaveState> build(int? postId) async {
    final runningOptions = await _repo.fetchRunRecordOptions();
    if (postId == null) {
      return PostSaveState(
        content: '',
        runRecordId: null,
        pictureIds: [],
        runRecordOptions: runningOptions,
      );
    } else {
      final post = await _repo.fetchPostDetail(postId);
      return PostSaveState(
        content: post.content,
        runRecordId: post.runRecordId,
        pictureIds: post.pictureIds,
        runRecordOptions: runningOptions,
      );
    }
  }

  void updateContent(String content) {
    state = AsyncData(state.value!.copyWith(content: content));
  }

  void updateRunRecordId(int id) {
    state = AsyncData(state.value!.copyWith(runRecordId: id));
  }

  void updatePictureIds(List<int> ids) {
    state = AsyncData(state.value!.copyWith(pictureIds: ids));
  }

  Future<void> savePost() async {
    final current = state.value!;
    if (current.runRecordId == null || current.content.isEmpty) {
      throw Exception('필수값 누락');
    }
    await _repo.savePost(current);
  }
}

// Repository 포함
class PostSaveRepository {
  Future<List<RunRecordOption>> fetchRunRecordOptions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final List<Map<String, dynamic>> dummyData = [
      {
        "id": 1,
        "title": "러닝 기록 1",
        "createdAt": "2025-07-01",
      },
      {
        "id": 2,
        "title": "러닝 기록 2",
        "createdAt": "2025-07-02",
      },
    ];
    return dummyData.map((e) => RunRecordOption.fromMap(e)).toList();
  }

  Future<PostSaveModel> fetchPostDetail(int postId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return PostSaveModel(
      id: postId,
      content: '기존 내용입니다',
      runRecordId: 1,
      pictureIds: [],
    );
  }

  Future<void> savePost(PostSaveState state) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print('저장 완료: ${state.content}');
  }
}

// 모델들
class PostSaveModel {
  final int id;
  final String content;
  final int runRecordId;
  final List<int> pictureIds;

  PostSaveModel({
    required this.id,
    required this.content,
    required this.runRecordId,
    required this.pictureIds,
  });
}

class RunRecordOption {
  final int id;
  final String title;
  final String createdAt;

  RunRecordOption({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory RunRecordOption.fromMap(Map<String, dynamic> map) {
    return RunRecordOption(
      id: map['id'],
      title: map['title'],
      createdAt: map['createdAt'],
    );
  }
}

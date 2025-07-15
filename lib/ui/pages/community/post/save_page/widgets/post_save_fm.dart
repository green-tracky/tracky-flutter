import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ 1단계: Provider 정의
/// 글쓰기 및 수정 둘 다 처리해야 해서 Family 사용.
final postSaveProvider = AsyncNotifierProviderFamily<PostSaveVM, PostSaveState, int?>(
  PostSaveVM.new,
);

/// ✅ 2단계: State 모델 정의
/// 화면에 데이터 바인딩할 때 사용할 상태.
class PostSaveState {
  final String content;
  final int? runRecordId;
  final List<int> pictureIds;

  PostSaveState({
    required this.content,
    required this.runRecordId,
    required this.pictureIds,
  });

  PostSaveState copyWith({
    String? content,
    int? runRecordId,
    List<int>? pictureIds,
  }) {
    return PostSaveState(
      content: content ?? this.content,
      runRecordId: runRecordId ?? this.runRecordId,
      pictureIds: pictureIds ?? this.pictureIds,
    );
  }
}

/// ✅ 3단계: ViewModel 정의 (데이터 바인딩 및 갱신 처리)
class PostSaveVM extends FamilyAsyncNotifier<PostSaveState, int?> {
  final _repo = PostSaveRepository();

  @override
  Future<PostSaveState> build(int? postId) async {
    if (postId == null) {
      /// 신규 작성
      return PostSaveState(content: '', runRecordId: null, pictureIds: []);
    } else {
      /// 수정 시 초기값 세팅
      final post = await _repo.fetchPostDetail(postId);
      return PostSaveState(
        content: post.content,
        runRecordId: post.runRecordId,
        pictureIds: post.pictureIds,
      );
    }
  }

  /// ✅ 내용 업데이트
  void updateContent(String content) {
    state = AsyncData(state.value!.copyWith(content: content));
  }

  /// ✅ 러닝 기록 ID 업데이트
  void updateRunRecordId(int id) {
    state = AsyncData(state.value!.copyWith(runRecordId: id));
  }

  /// ✅ 사진 ID 리스트 업데이트
  void updatePictureIds(List<int> ids) {
    state = AsyncData(state.value!.copyWith(pictureIds: ids));
  }

  /// ✅ 저장 요청
  Future<void> savePost() async {
    final current = state.value!;
    if (current.runRecordId == null || current.content.isEmpty) {
      throw Exception('필수값 누락');
    }
    await _repo.savePost(current);
  }
}

/// ✅ 4단계: Repository 더미 예시
class PostSaveRepository {
  Future<PostSaveModel> fetchPostDetail(int postId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return PostSaveModel(
      id: postId,
      content: '기존 내용입니다',
      runRecordId: 10,
      pictureIds: [1, 2],
    );
  }

  Future<void> savePost(PostSaveState state) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('저장 완료: ${state.content}');
  }
}

/// ✅ 5단계: 저장 모델
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

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/dio.dart';
import 'package:tracky_flutter/data/model/Friend.dart';

/// FriendRepository
class FriendRepository {
  final Dio dio;
  FriendRepository(this.dio);

  // 1. 친구 태그로 검색
  Future<List<UserProfile>> searchFriendByTag(String tag) async {
    print('[Repo] 친구 검색 요청: $tag');
    final response = await dio.get(
      '/friends/search',
      queryParameters: {'user-tag': tag},
    );
    print('[Repo] 응답: ${response.data}');

    final resData = response.data['data'];
    if (resData is List) {
      print('[Repo] 친구 ${resData.length}명 파싱 중');
      return resData.map((e) => UserProfile.fromJson(e)).toList();
    } else {
      print('[Repo] data가 List가 아님: $resData (${resData.runtimeType})');
      return [];
    }
  }

  // 2. 친구 요청 (userId로 요청)
  Future<void> inviteFriend(int userId) async {
    print('[Repo] 친구 요청 시작 → 대상 userId: $userId');

    try {
      final response = await dio.post('/friends/invite/users/$userId');
      print('[Repo] 친구 요청 응답: ${response.data}');
    } catch (e, st) {
      print('[Repo] 친구 요청 실패: $e\n$st');
      rethrow;
    }
  }

  // 3. 친구 리스트 (내 전체 친구)
  Future<List<Friend>> fetchFriendList() async {
    try {
      final response = await dio.get('/friends/list');
      print('친구 목록 서버 응답: ${response.data}');

      final resData = response.data['data'];
      if (resData is List) {
        print('친구 리스트 파싱 성공! ${resData.length}명');
        return resData.map((e) => Friend.fromJson(e)).toList();
      } else {
        print('data가 List가 아님: $resData (${resData.runtimeType})');
        return [];
      }
    } catch (e, st) {
      print('친구 리스트 API 에러: $e\n$st');
      rethrow;
    }
  }
}

/// Provider for Repository
final friendRepositoryProvider = Provider<FriendRepository>(
  (ref) => FriendRepository(dio), // 전역 dio 인스턴스 주입
);

/// 친구 "검색/추가" StateNotifier & Provider
class SearchFriendNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  final Ref ref;
  SearchFriendNotifier(this.ref) : super(const AsyncValue.data([]));

  // 검색
  Future<void> search(String tag) async {
    print('[ViewModel] search() 호출됨 with tag: $tag'); // 호출 확인용
    if (tag.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    try {
      state = const AsyncValue.loading();
      final repo = ref.read(friendRepositoryProvider);
      final results = await repo.searchFriendByTag(tag);
      state = AsyncValue.data(results);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // 친구 요청
  Future<void> invite(int userId) async {
    try {
      final repo = ref.read(friendRepositoryProvider);
      await repo.inviteFriend(userId);
    } catch (e) {
      // 필요시 에러 처리
    }
  }
}

final searchFriendProvider = StateNotifierProvider<SearchFriendNotifier, AsyncValue<List<UserProfile>>>(
  (ref) => SearchFriendNotifier(ref),
);

/// 친구 "리스트" StateNotifier & Provider
class FriendListNotifier extends StateNotifier<AsyncValue<List<Friend>>> {
  final Ref ref;
  FriendListNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> fetchFriends() async {
    try {
      final repo = ref.read(friendRepositoryProvider);
      print('친구 목록 불러오기 시작');
      final friends = await repo.fetchFriendList();
      print('받아온 친구 리스트: $friends');
      state = AsyncValue.data(friends);
    } catch (e, st) {
      print('Provider에서 친구 목록 불러오기 실패: $e\n$st');
      state = AsyncValue.error(e, st);
    }
  }
}

final friendListProvider = StateNotifierProvider<FriendListNotifier, AsyncValue<List<Friend>>>(
  (ref) => FriendListNotifier(ref),
);

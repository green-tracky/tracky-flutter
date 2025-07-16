import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/utils/dio.dart';
import 'package:tracky_flutter/data/model/Friend.dart';
import 'package:tracky_flutter/data/repository/FriendRepository.dart';

/// FriendRepository Provider
final friendRepositoryProvider = Provider<FriendRepository>(
  (ref) => FriendRepository(ref.read(dioProvider)),
);

/// 검색 상태 관리
class SearchFriendNotifier extends StateNotifier<AsyncValue<List<UserProfile>>> {
  final Ref ref;
  SearchFriendNotifier(this.ref) : super(const AsyncValue.data([]));

  /// 친구 검색
  Future<void> search(String tag) async {
    print('[ViewModel] 친구 검색 실행: $tag');
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

  /// 친구 요청
  Future<void> invite(int userId) async {
    try {
      final repo = ref.read(friendRepositoryProvider);
      await repo.inviteFriend(userId);
    } catch (e) {
      print('[ViewModel] 친구 요청 실패: $e');
      rethrow;
    }
  }
}

final searchFriendProvider = StateNotifierProvider<SearchFriendNotifier, AsyncValue<List<UserProfile>>>(
  (ref) => SearchFriendNotifier(ref),
);

/// 친구 리스트 상태 관리
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

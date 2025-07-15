import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Friend.dart';

class FriendListNotifier extends StateNotifier<AsyncValue<List<Friend>>> {
  FriendListNotifier() : super(const AsyncValue.loading());

  Future<void> fetchFriends() async {
    try {
      // 서버 통신 시 delay 예시 (삭제 가능)
      await Future.delayed(Duration(seconds: 2));
      // 실제 서버 통신 코드
      state = AsyncValue.data([
        Friend(id: 1, username: "love", profileUrl: "https://..."),
        Friend(id: 2, username: "haha", profileUrl: "https://..."),
      ]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final friendListProvider = StateNotifierProvider<FriendListNotifier, AsyncValue<List<Friend>>>(
  (ref) => FriendListNotifier(),
);

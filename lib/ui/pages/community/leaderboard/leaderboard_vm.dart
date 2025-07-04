import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Leaderboard.dart';
import 'package:tracky_flutter/data/repository/LeaderboardRepository.dart';

final rankListProvider =
    StateNotifierProvider<RankListViewModel, AsyncValue<List<RankUser>>>(
      (ref) => RankListViewModel(ref),
    );

class RankListViewModel extends StateNotifier<AsyncValue<List<RankUser>>> {
  final Ref ref;
  String selectedFilter = '이번 달 친구 기록(KM)';

  RankListViewModel(this.ref) : super(const AsyncValue.loading()) {
    fetchRankList();
  }

  void changeFilter(String newFilter) {
    selectedFilter = newFilter;
    fetchRankList();
  }

  Future<void> fetchRankList() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(leaderboardRepositoryProvider); // provider로 바인딩 가능
      final result = await repo.getRankListByFilter(selectedFilter);
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

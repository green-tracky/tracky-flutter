import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/rank_vm.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_bottom_filter.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_header.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_my_rank_card.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_text.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_user_tile.dart';

class RankBody extends ConsumerStatefulWidget {
  const RankBody({super.key});

  @override
  ConsumerState<RankBody> createState() => _RankBodyState();
}

class _RankBodyState extends ConsumerState<RankBody> {
  @override
  void initState() {
    super.initState();
    // 랭킹 데이터 더미 로딩 (실전에서는 fetchRankingData async로 수정)
    Future.microtask(() => ref.read(rankingProvider.notifier).fetchRankingData(ref.read(rankFilterProvider)));
  }

  void showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    final options = ['이번 주 친구 기록(KM)', '지난 주 친구 기록(KM)', '이번 달 친구 기록(KM)', '지난 달 친구 기록(KM)', '올해 친구 기록(KM)'];
    final selected = ref.read(rankFilterProvider);
    RankFilter(context, options, selected, ref);
  }

  @override
  Widget build(BuildContext context) {
    final rankingState = ref.watch(rankingProvider);
    // 예: final selected = ref.read(rankingProvider.notifier).selectedFilter;
    // → 필터 기능도 랭킹 Provider에서 관리하면 이와 같이
    final selected = ref.watch(rankFilterProvider);

    final myRanking = rankingState.myRankingRaw;
    final rankingList = rankingState.rankingList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 내 랭킹 카드(넓게!)
        if (myRanking != null)
    MyRankingCard(
      rank: myRanking['rank'],
      totalDistanceMeters: myRanking['totalDistanceMeters'],
    ),
        Divider(thickness: 1),
        RankHeader(selected, () => showFilterBottomSheet(context, ref)),
        Divider(thickness: 1),
        RankText(),
        Divider(thickness: 1),
        // 친구 랭킹 리스트
        Expanded(
          child: ListView.separated(
            itemCount: rankingList.length,
            separatorBuilder: (_, __) => Divider(thickness: 1),
            itemBuilder: (context, index) {
              final user = rankingList[index];
              return RankUserTile(user); // user는 RankingUser 타입
            },
          ),
        ),
      ],
    );
  }
}

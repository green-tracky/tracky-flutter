import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/leaderboard_vm.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_bottom_filter.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_header.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_leader_board.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_text.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/widgets/rank_user_tile.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

class RankPage extends ConsumerWidget {
  const RankPage({super.key});

  void showFilterBottomSheet(
    BuildContext context,
    WidgetRef ref,
    String selected,
  ) {
    final options = [
      '이번 주 친구 기록(KM)',
      '지난 주 친구 기록(KM)',
      '이번 달 친구 기록(KM)',
      '지난 달 친구 기록(KM)',
      '올해 친구 기록(KM)',
    ];

    RankFilter(context, options, selected, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(rankListProvider);
    final selected = ref.read(rankListProvider.notifier).selectedFilter;

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: CommonAppBar(),
      ),
      endDrawer: CommunityDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RankLeaderBoard(),
          Divider(thickness: 1),
          RankHeader(
            selected,
            () => showFilterBottomSheet(context, ref, selected),
          ),
          Divider(thickness: 1),
          RankText(),
          Divider(thickness: 1),
          Expanded(
            child: vm.when(
              data: (users) => ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return RankUserTile(user);
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('불러오기 실패')),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: CommonBottomNav(),
    );
  }
}

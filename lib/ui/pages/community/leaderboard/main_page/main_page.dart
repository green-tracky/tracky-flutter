import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/widgets/leaderboard_background.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/widgets/leaderboard_button.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/widgets/leaderboard_description.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/widgets/leaderboard_title.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/rank_page.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_vm.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

class LeaderboardMainPage extends ConsumerStatefulWidget {
  const LeaderboardMainPage({super.key});

  @override
  ConsumerState<LeaderboardMainPage> createState() => _LeaderboardMainPageState();
}

class _LeaderboardMainPageState extends ConsumerState<LeaderboardMainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(friendListProvider.notifier).fetchFriends());
  }

  @override
  Widget build(BuildContext context) {
    final friendsAsync = ref.watch(friendListProvider);

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: CommonAppBar(),
      endDrawer: CommunityDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeaderboardTitle(),
          Expanded(
            child: friendsAsync.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('친구 정보를 불러올 수 없습니다')),
              data: (friends) => friends.isEmpty
                  // 친구 없으면 설명/초대 UI
                  ? LeaderboardBackground(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            LeaderboardDescription(),
                            Gap.l,
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: LeaderboardInviteButton(),
                            ),
                          ],
                        ),
                      ),
                    )
                  // 친구 있으면 랭킹 UI
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
                      child: RankBody(), // 랭킹 바디는 기존대로
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

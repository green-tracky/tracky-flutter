import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/friend/friend_list_page/widgets/friend_app_bar.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/friend/friend_list_page/widgets/friend_divider.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/friend/friend_list_page/widgets/friend_tile.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/friend/friend_vm.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_vm.dart';

class ChallengeFriendListPage extends ConsumerStatefulWidget {
  final int challengeId; // <--- Declare challengeId here

  const ChallengeFriendListPage({
    super.key,
    required this.challengeId, // <--- Add it to the constructor
  });

  @override
  ConsumerState<ChallengeFriendListPage> createState() =>
      _ChallengeFriendListPageState();
}

class _ChallengeFriendListPageState
    extends ConsumerState<ChallengeFriendListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(friendChallengeListProvider.notifier).fetchChallengeFriends(widget.challengeId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final friendsAsync = ref.watch(friendChallengeListProvider);

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ListFriendAppBar(),
      ),
      body: friendsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) {
          print('UI에서 친구 정보 에러: $e');
          return Center(child: Text('친구 정보를 불러올 수 없습니다\n$e'));
        },
        data: (friends) {
          if (friends.isEmpty) {
            return Center(child: Text('친구가 없습니다'));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: friends.length,
            separatorBuilder: (context, index) => const ListFriendDivider(),
            itemBuilder: (context, index) {
              final friend = friends[index];
              return ListFriendTile(
                challengeId: widget.challengeId,
                name: friend.username,
                userId: friend.id,
              );
            },
          );
        },
      ),
    );
  }
}

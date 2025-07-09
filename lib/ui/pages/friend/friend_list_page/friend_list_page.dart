import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_list_page/widgets/friend_app_bar.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_list_page/widgets/friend_divider.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_list_page/widgets/friend_tile.dart';

class ListFriendPage extends StatelessWidget {
  const ListFriendPage({super.key});

  final List<String> dummyFriends = const ['ssar', 'cos', 'love', 'haha'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ListFriendAppBar(),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: dummyFriends.length,
        separatorBuilder: (context, index) => const ListFriendDivider(),
        itemBuilder: (context, index) {
          final name = dummyFriends[index];
          return ListFriendTile(name: name);
        },
      ),
    );
  }
}

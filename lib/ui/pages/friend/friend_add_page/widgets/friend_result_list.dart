import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/widgets/friend_list_tile.dart';

class AddFriendResultList extends StatelessWidget {
  final String tag;

  const AddFriendResultList({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final dummyUsers = [
      {'tag': '#ssar', 'name': '쌀 김', 'email': 'ssar@nate.com'},
      {'tag': '#green', 'name': '초록 이', 'email': 'green@nate.com'},
    ];

    final results = dummyUsers.where((user) => user['tag'] == tag).toList();

    if (results.isEmpty) {
      return Text(
        '"$tag" 태그로 검색된 친구 없음',
        style: const TextStyle(color: Colors.black),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final user = results[index];
        return AddFriendListTile(
          name: user['name']!,
          email: user['email']!,
        );
      },
    );
  }
}

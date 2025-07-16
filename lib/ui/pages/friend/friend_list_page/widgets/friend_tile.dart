import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/friend_detail_page.dart';

class ListFriendTile extends StatelessWidget {
  final String name;
  final int userId;

  const ListFriendTile({super.key, required this.name, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailFriendPage(
                name: name,
                email: '$name@nate.com',
                userId: userId,
                isFriend: true,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/friend_detail_page.dart';

class AddFriendListTile extends StatelessWidget {
  final String name;
  final String email;
  final int userId;
  final bool isFriend;
  final VoidCallback? onTap;

  const AddFriendListTile({
    super.key,
    required this.name,
    required this.email,
    required this.userId,
    required this.isFriend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
              () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailFriendPage(
                  name: name,
                  email: email,
                  userId: userId,
                  isFriend: isFriend,
                ),
              ),
            );
          },
      borderRadius: BorderRadius.circular(4),
      hoverColor: Colors.black12,
      mouseCursor: SystemMouseCursors.click,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          child: Text(name[0]),
        ),
        title: Text(name),
        subtitle: Text(email),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

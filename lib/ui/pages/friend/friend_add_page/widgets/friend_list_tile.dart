import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/friend_detail_page.dart';

class AddFriendListTile extends StatelessWidget {
  final String name;
  final String email;

  const AddFriendListTile({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailFriendPage(name: name, email: email),
          ),
        );
      },
      borderRadius: BorderRadius.circular(4),
      hoverColor: Colors.black12,
      mouseCursor: SystemMouseCursors.click,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          child: Text(
            name[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF021F59),
          ),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

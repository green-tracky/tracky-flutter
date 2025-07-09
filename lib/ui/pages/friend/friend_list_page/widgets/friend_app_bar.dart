import 'package:flutter/material.dart';

import '../../friend_add_page/friend_add_page.dart';

class ListFriendAppBar extends StatelessWidget {
  const ListFriendAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const Center(
          child: Text(
            '친구',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF021F59),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.person_add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFriendPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}

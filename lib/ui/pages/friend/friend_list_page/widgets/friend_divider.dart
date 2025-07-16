import 'package:flutter/material.dart';

class ListFriendDivider extends StatelessWidget {
  const ListFriendDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Colors.black,
        thickness: 1,
        height: 24,
      ),
    );
  }
}

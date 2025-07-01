import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/detail_friend_page.dart';

import 'add_friend_page.dart';

class ListFriendPage extends StatelessWidget {
  const ListFriendPage({super.key});

  final List<String> dummyFriends = const ['ssar', 'cos', 'love', 'haha'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                '친구',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF021F59),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(Icons.person_add, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddFriendPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 12),
        itemCount: dummyFriends.length,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            color: Colors.black,
            thickness: 1,
            height: 24,
          ),
        ),
        itemBuilder: (context, index) {
          final name = dummyFriends[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                name,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 4),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailFriendPage(
                      name: name,
                      email: '$name@nate.com',
                      isFriend: true,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

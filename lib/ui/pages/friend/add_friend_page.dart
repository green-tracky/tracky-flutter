import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});
  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: isSearching
                    ? TextField(
                        controller: searchController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: '태그로 친구 검색',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            query = value.trim();
                          });
                        },
                      )
                    : Text(
                        '친구 추가',
                        style: TextStyle(
                          color: Color(0xFF021F59),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
              ),
            ),
            IconButton(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    searchController.clear();
                    query = '';
                  }
                  isSearching = !isSearching;
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade400,
          ),
          Expanded(
            child: Center(
              child: query.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '태그를 입력하세요',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '친구를 찾기 위해 #태그를 입력하세요.\n예: #ssar, #green',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    )
                  : buildSearchResults(query),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResults(String tag) {
    // 예시 더미 데이터
    final dummyUsers = [
      {'tag': '#ssar', 'name': '쌀 김', 'email': 'ssar@nate.com'},
      {'tag': '#green', 'name': '초록 이', 'email': 'green@nate.com'},
    ];

    // 입력 태그와 일치하는 유저 필터링
    final results = dummyUsers.where((user) => user['tag'] == tag).toList();

    if (results.isEmpty) {
      return Text(
        '"$tag" 태그로 검색된 친구 없음',
        style: TextStyle(color: Colors.black),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final user = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            child: Text(
              user['name']![0], // 이름 첫 글자
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            user['name']!,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          subtitle: Text(
            user['email']!,
            style: TextStyle(color: Colors.grey[700]),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FriendDetailPage(
                      name: user['name']!,
                      email: user['email']!,
                    ),
                  ),
                );
              },
          ),
        );
      },
    );
  }
}

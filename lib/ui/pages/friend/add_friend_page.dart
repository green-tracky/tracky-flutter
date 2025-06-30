import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});
  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> with TickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        automaticallyImplyLeading: false, // leading 직접 구성
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: isSearching
                    ? TextField(
                        controller: searchController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: '친구 검색',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          // 검색 처리
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
            Row(
              children: [
                isSearching
                    ? IconButton(
                        icon: Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            isSearching = false;
                            searchController.clear();
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.search, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                      ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: '추천'),
            Tab(text: '연락처'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Center(
            child: Text(
              '추천 친구 목록 구현 예정',
              style: TextStyle(color: Color(0xFF021F59), fontSize: 24),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '연락처를 찾을 수 없음',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  '이메일과 일치하는 연락처가 없습니다.\n검색을 통해 나이키에서 친구를 찾아보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

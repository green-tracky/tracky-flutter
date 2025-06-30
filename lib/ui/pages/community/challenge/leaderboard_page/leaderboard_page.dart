import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final int myRank; // 예: 18
  final List<Map<String, dynamic>> leaderboard;

  const LeaderboardPage({
    super.key,
    required this.myRank,
    required this.leaderboard,
  });

  @override
  Widget build(BuildContext context) {
    final top10 = leaderboard.take(10).toList();
    final bool isMyRankTop10 = myRank <= 10;

    // 👇 dynamic 타입으로 변경 (중간에 gap 마커를 넣기 위해)
    List<dynamic> displayList = [...top10];

    if (!isMyRankTop10 && myRank <= leaderboard.length) {
      final myIndex = myRank - 1; // 0-based index
      final above = myIndex - 1 >= 10 ? leaderboard[myIndex - 1] : null;
      final current = leaderboard[myIndex];
      final below = myIndex + 1 < leaderboard.length ? leaderboard[myIndex + 1] : null;

      displayList.add('__gap__'); // 👈 중간 생략 마커

      if (above != null) displayList.add(above);
      displayList.add(current);
      if (below != null) displayList.add(below);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("리더보드"),
        backgroundColor: const Color(0xFFF9FAEB),
        elevation: 0.5,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF9FAEB),
      body: ListView.separated(
        itemCount: displayList.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = displayList[index];

          if (item is String && item == '__gap__') {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              color: Colors.grey[400],
              child: const Text(
                "...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final user = item as Map<String, dynamic>;
          final rank = leaderboard.indexOf(user) + 1;
          final isMe = rank == myRank;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(
                rank.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              user['name'],
              style: TextStyle(
                fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                color: isMe ? const Color(0xFF021F59) : Colors.black,
              ),
            ),
            trailing: Text(
              "${user['distance']} km",
              style: TextStyle(
                fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                color: isMe ? const Color(0xFF021F59) : Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }
}

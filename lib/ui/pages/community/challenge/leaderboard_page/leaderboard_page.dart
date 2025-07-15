import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/detail_page/detail_page_vm.dart';

class LeaderboardPage extends StatelessWidget {
  final int myRank; // 내 랭크 (1-based)
  final double totalDistance; // 챌린지 전체 거리 (km)
  final List<RankingEntry> leaderboard; // 랭킹 리스트

  const LeaderboardPage({
    super.key,
    required this.myRank,
    required this.totalDistance,
    required this.leaderboard,
  });

  @override
  Widget build(BuildContext context) {
    final top10 = leaderboard.take(10).toList();
    final bool isMyRankTop10 = myRank <= 10;

    List<dynamic> displayList = [...top10];

    if (!isMyRankTop10 && myRank <= leaderboard.length) {
      final myIndex = myRank - 1;
      final above = myIndex - 1 >= 10 ? leaderboard[myIndex - 1] : null;
      final current = leaderboard[myIndex];
      final below = myIndex + 1 < leaderboard.length
          ? leaderboard[myIndex + 1]
          : null;

      displayList.add('__gap__'); // 생략 마커

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

          final user = item as RankingEntry;
          final isMe = user.rank == myRank;
          final progressRatio = _calculateProgress(
            user.totalDistanceMeters.toDouble(),
            totalDistance,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Text(
                        user.rank.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: TextStyle(
                              fontWeight: isMe
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isMe
                                  ? const Color(0xFF021F59)
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: progressRatio,
                            minHeight: 6,
                            color: const Color(0xFF021F59),
                            backgroundColor: const Color(
                              0xFF021F59,
                            ).withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "${(user.totalDistanceMeters / 1000).toStringAsFixed(2)} km",
                      style: TextStyle(
                        fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                        color: isMe ? const Color(0xFF021F59) : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _calculateProgress(double distanceMeters, double totalDistanceKm) {
    final currentKm = distanceMeters / 1000;
    return (totalDistanceKm == 0)
        ? 0.0
        : (currentKm / totalDistanceKm).clamp(0.0, 1.0);
  }
}

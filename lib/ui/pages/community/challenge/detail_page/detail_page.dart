import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/leaderboard_page/leaderboard_page.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String title;
  final String dDay;
  final String progress;
  final String totalDistance;
  final String desc;
  final bool isJoined;

  ChallengeDetailPage({
    super.key,
    required this.title,
    required this.dDay,
    required this.progress,
    required this.totalDistance,
    required this.desc,
    required this.isJoined,
  });

  final List<Map<String, dynamic>> sampleLeaderboard = [
    {'name': 'Mario Jose Zambrano', 'distance': 3669},
    {'name': 'Masami Nakada', 'distance': 2711},
    {'name': 'Muhammad Rifai', 'distance': 1930},
    {'name': 'Cynthia Johnson', 'distance': 1876},
    {'name': 'Takahiro NAKASHIMA', 'distance': 1824},
    {'name': 'Michael Pereira', 'distance': 1301},
    {'name': 'David Wright', 'distance': 1288},
    {'name': 'Ace Gutter', 'distance': 1163},
    {'name': 'Robert Chang', 'distance': 1128},
    {'name': 'Don friend', 'distance': 1072},
    {'name': 'Lee Sun', 'distance': 998},
    {'name': 'Kang Min', 'distance': 943},
    {'name': 'Tom Hardy', 'distance': 882},
    {'name': 'Alex Kim', 'distance': 845},
    {'name': 'Emma Stone', 'distance': 790},
    {'name': 'Jin Young', 'distance': 722},
    {'name': 'Park Sohee', 'distance': 688},
    {'name': 'sxias', 'distance': 659}, // 👈 당신의 유저 (18등)
    {'name': 'Daniel Cho', 'distance': 640},
    {'name': 'Zuko Menzani', 'distance': 618},
  ];

  int myRank = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showChallengeOptions(context),
          ),
        ],
        backgroundColor: const Color(0xFFF9FAEB),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF9FAEB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Center(child: Placeholder()),

            const SizedBox(height: 16),
            Center(
              child: Text(
                dDay,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

            const SizedBox(height: 8),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),
            Center(
              child: Text(
                desc,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                "이번 달에 목표를 달성하고 완주자 기록을 달성하세요.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            if (isJoined)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 진행도 텍스트
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: progress.trim(), // 예: "0.18"
                                style: const TextStyle(
                                  color: Color(0xFF021F59),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: ' / ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: totalDistance.trim(), // 예: "100.0km"
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 뱃지 Placeholder
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: Placeholder(),
                        ),
                      ],
                    ),
                  ),
                  LinearProgressIndicator(
                    value: _calculateProgress(progress, totalDistance),
                    minHeight: 6,
                    color: const Color(0xFF021F59),
                    backgroundColor: const Color(0xFF021F59).withOpacity(0.2),
                  ),

                  const SizedBox(height: 32),

                  // 순위 표시
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("순위", style: TextStyle(fontSize: 16)),
                      Text(
                        "$myRank / ${sampleLeaderboard.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  // const Divider(height: 32),
                  const SizedBox(height: 32),
                  // 리더보드 보기
                  Card(
                    color: Color(0xFFF9FAEB),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Color(0xFF021F59),
                        width: 1,
                      ),
                    ),
                    elevation: 2,
                    child: ListTile(
                      title: const Text(
                        "리더보드 보기",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF021F59),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(0xFF021F59),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LeaderboardPage(
                              myRank: 18,
                              leaderboard: sampleLeaderboard,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // const Divider(height: 16),
                ],
              ),
            const SizedBox(height: 32),
            const Text("총 거리", style: TextStyle(color: Colors.grey)),
            Text(
              totalDistance,
              style: const TextStyle(fontSize: 16),
            ),

            if (isJoined) ...[
              const SizedBox(height: 16),
              const Text("달린 거리", style: TextStyle(color: Colors.grey)),
              Text(progress, style: const TextStyle(fontSize: 16)),
            ],

            const SizedBox(height: 16),
            const Text("운동 기간", style: TextStyle(color: Colors.grey)),
            const Text("6월 1일~30일", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 16),
            const Text("참가자", style: TextStyle(color: Colors.grey)),
            const Text("42,049명", style: TextStyle(fontSize: 16)),

            const SizedBox(height: 32),
            const Text("리워드 획득", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 40, height: 40, child: Placeholder()),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    const Text("달성", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isJoined
          ? null // 챌린지에 참여 중이면 버튼을 표시하지 않음
          : SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: FloatingActionButton.extended(
                backgroundColor: Color(0xFFD0F252),
                onPressed: () {
                  // 참여 로직
                },
                label: const Text(
                  "챌린지 참여하기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF021F59),
                  ),
                ),
              ),
            ),
    );
  }

  void _showChallengeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Center(
                    child: Text(
                      "챌린지 정보",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint("챌린지 정보 보기");
                  },
                ),
                const Divider(height: 1, thickness: 1),
                if (isJoined)
                  ListTile(
                    title: const Center(
                      child: Text(
                        "챌린지 종료",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      debugPrint("챌린지 종료");
                    },
                  ),
                if (!isJoined)
                  ListTile(
                    title: const Center(
                      child: Text(
                        "챌린지 참가",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      debugPrint("챌린지 참가");
                    },
                  ),
                const Divider(height: 1),
                ListTile(
                  title: const Center(
                    child: Text(
                      "취소",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _calculateProgress(String progress, String totalDistance) {
    try {
      final double current = double.parse(progress.replaceAll("km", "").trim());
      final double total = double.parse(
        totalDistance.replaceAll("km", "").trim(),
      );
      return (total == 0) ? 0.0 : (current / total).clamp(0.0, 1.0);
    } catch (_) {
      return 0.0;
    }
  }
}

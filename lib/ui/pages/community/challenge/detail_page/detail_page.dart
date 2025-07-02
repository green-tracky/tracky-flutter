import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/info_page/info_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/leaderboard_page/leaderboard_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/update_page/update_page.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String title;
  final String dDay;
  final String progress;
  final String totalDistance;
  final String desc;
  final bool isJoined;

  // ✅ 내가 만든 챌린지인지 여부
  final bool isCreatedByMe;

  ChallengeDetailPage({
    super.key,
    required this.title,
    required this.dDay,
    required this.progress,
    required this.totalDistance,
    required this.desc,
    required this.isJoined,
    this.isCreatedByMe = false, // 기본값 false
  });

  final List<Map<String, dynamic>> sampleLeaderboard = [
    {'name': 'Mario Jose Zambrano', 'distance': 36.69},
    {'name': 'Masami Nakada', 'distance': 27.11},
    {'name': 'Muhammad Rifai', 'distance': 19.30},
    {'name': 'Cynthia Johnson', 'distance': 18.76},
    {'name': 'Takahiro NAKASHIMA', 'distance': 18.24},
    {'name': 'Michael Pereira', 'distance': 13.01},
    {'name': 'David Wright', 'distance': 12.88},
    {'name': 'Ace Gutter', 'distance': 11.63},
    {'name': 'Robert Chang', 'distance': 11.28},
    {'name': 'Don friend', 'distance': 10.72},
    {'name': 'Lee Sun', 'distance': 9.98},
    {'name': 'Kang Min', 'distance': 9.43},
    {'name': 'Tom Hardy', 'distance': 8.82},
    {'name': 'Alex Kim', 'distance': 8.45},
    {'name': 'Emma Stone', 'distance': 7.90},
    {'name': 'Jin Young', 'distance': 7.22},
    {'name': 'Park Sohee', 'distance': 6.88},
    {'name': 'sxias', 'distance': 6.59},
    {'name': 'Daniel Cho', 'distance': 6.40},
    {'name': 'Zuko Menzani', 'distance': 6.18},
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
              child: Text(dDay, style: const TextStyle(color: Colors.grey)),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: progress.trim(),
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
                                text: totalDistance.trim(),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("순위", style: TextStyle(fontSize: 16)),
                      Text(
                        "$myRank / ${sampleLeaderboard.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Card(
                    color: const Color(0xFFF9FAEB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Color(0xFF021F59)),
                    ),
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
                              totalDistance: double.parse(
                                totalDistance.replaceAll("km", "").trim(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 32),
            const Text("총 거리", style: TextStyle(color: Colors.grey)),
            Text(totalDistance, style: const TextStyle(fontSize: 16)),
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
          ? null
          : SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFFD0F252),
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
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text("챌린지 옵션"),
        message: const Text("아래에서 원하는 작업을 선택하세요."),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ChallengeInfoPage(),
                ),
              );
            },
            child: const Text(
              "챌린지 정보",
              style: TextStyle(color: Color(0xFF007AFF)),
            ),
          ),
          if (isCreatedByMe)
  CupertinoActionSheetAction(
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChallengeUpdatePage(
            initialName: title,
            initialImageIndex: 0, // 실제 index 값으로 수정하세요
          ),
        ),
      );
    },
    child: const Text(
      "챌린지 수정",
      style: TextStyle(color: Color(0xFF007AFF)),
    ),
  ),
          if (isJoined)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                debugPrint("챌린지 종료");
              },
              child: const Text("챌린지 종료"),
            ),
          if (!isJoined)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                debugPrint("챌린지 참가");
              },
              child: const Text(
                "챌린지 참가",
                style: TextStyle(color: Color(0xFF007AFF)),
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "취소",
            style: TextStyle(
              color: Color(0xFF007AFF),
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
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

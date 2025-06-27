import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String title;
  final String dDay;
  final String progress;
  final String totalDistance;
  final String desc;
  final bool isJoined;

  const ChallengeDetailPage({
    super.key,
    required this.title,
    required this.dDay,
    required this.progress,
    required this.totalDistance,
    required this.desc,
    required this.isJoined,
  });

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
                    children: const [
                      Text("순위", style: TextStyle(fontSize: 16)),
                      Text(
                        "41067 / 42050",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  // const Divider(height: 32),
                  const SizedBox(height:32),
                  // 리더보드 보기
                  Card(
                    color: Color(0xFFF9FAEB),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Color(0xFF021F59), width:1,)
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
                        debugPrint("리더보드 보기 클릭됨");
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
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xFFD0F252),
          onPressed: () {
            // 참여 로직
          },
          label: const Text("챌린지 참여하기", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:Color(0xFF021F59))),
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

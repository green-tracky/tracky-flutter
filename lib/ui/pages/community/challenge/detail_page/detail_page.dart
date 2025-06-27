import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final String title;
  final String dDay;
  final String? progress; // optional
  final String? desc;

  const ChallengeDetailPage({
    super.key,
    required this.title,
    required this.dDay,
    this.progress,
    this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 100), // 하단 버튼 고려한 패딩
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Placeholder(), // 이미지 Placeholder
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(dDay, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            if (desc != null)
              Center(
                child: Text(desc!, style: const TextStyle(fontSize: 14)),
              ),
            const SizedBox(height: 16),
            if (desc != null)
              Text(
                "$desc\n이번 달에 목표를 달성하고 완주자 기록을 달성하세요.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            const SizedBox(height: 32),
            const Text("총 거리", style: TextStyle(color: Colors.grey)),
            Text(
              progress?.split('/').last.trim() ?? '100.0km',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text("운동 기간", style: TextStyle(color: Colors.grey)),
            const Text("6월 1일~30일", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text("참가자", style: TextStyle(color: Colors.grey)),
            const Text("42,049명", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            const Text("리워드 획득",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: Placeholder(),
                ),
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
          backgroundColor: Colors.pinkAccent,
          onPressed: () {
            // 참여 로직
          },
          label: const Text("챌린지 참여하기", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}

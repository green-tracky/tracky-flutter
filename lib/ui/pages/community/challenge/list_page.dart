import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';

class ChallengeListPage extends StatelessWidget {
  const ChallengeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myChallenges = [
      {"title": "6월 100K 챌린지", "progress": "23.4 / 100.0km", "dDay": "13일 남음"},
      {"title": "6월 30K 챌린지", "progress": "12.0 / 30.0km", "dDay": "13일 남음"},
    ];

    final joinableChallenges = [
      {"title": "6월 주간 챌린지", "desc": "이번 주 5km를 달려보세요.", "dDay": "5일 남음"},
      {"title": "6월 주간 챌린지", "desc": "이번 주 15km를 달려보세요.", "dDay": "5일 남음"},
      {"title": "6월 주간 챌린지", "desc": "이번 주 10km를 달려보세요.", "dDay": "5일 남음"},
      {"title": "6월 100K 챌린지", "desc": "이번 달 100km를 달려보세요.", "dDay": "13일 남음"},
      {"title": "6월 25K 챌린지", "desc": "이번 달 25km를 달려보세요.", "dDay": "13일 남음"},
      {"title": "6월 30K 챌린지", "desc": "이번 달 30km를 달려보세요.", "dDay": "13일 남음"},
    ];

    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Color(0xFFF9FAEB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("챌린지", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF021F59),),),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(aspectRatio: 16 / 9, child: Placeholder()),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text("챌린지 만들기", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF021F59),),),
              ),
            ),
            const SizedBox(height: 24),
            const Text("나의 챌린지", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF021F59),)),
            const SizedBox(height: 8),
            ...buildChallengeCards(myChallenges),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "챌린지 참여하기",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF021F59),),
                ),
                TextButton(onPressed: () {}, child: const Text("모두 보기", style: TextStyle(color: Color(0xFF021F59),),)),
              ],
            ),
            ...buildChallengeCards(joinableChallenges),
          ],
        ),
      ),
    );
  }

  List<Widget> buildChallengeCards(List<Map<String, String>> challenges) {
    return challenges.map((c) {
      return Card(
        color: Color(0xFFF9FAEB),
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: InkWell(
          onTap: () {
            debugPrint('Tapped on ${c["title"]}');
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const SizedBox(width: 48, height: 48, child: Placeholder()),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c["title"] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF021F59),),
                      ),
                      const SizedBox(height: 4),
                      // 챌린지 진행률과 설명을 줄바꿈으로 함께 출력
                      if (c.containsKey("progress"))
                        Text(
                          c["progress"]!,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      if (c.containsKey("desc"))
                        Text(
                          c["desc"]!,
                          style: const TextStyle(color: Color(0xFF021F59),),
                        ),
                      if (c.containsKey("dDay"))
                        Text(
                          c["dDay"]!,
                          style: const TextStyle(color: Color(0xFF021F59),),
                        ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF021F59),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

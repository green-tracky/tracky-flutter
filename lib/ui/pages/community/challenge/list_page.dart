import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/create_page/create_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

class ChallengeListPage extends StatelessWidget {
  const ChallengeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myChallenges = [
      {
        "title": "6월 100K 챌린지",
        "desc": "이번 달 100km를 달려보세요.",
        "totalDistance": "100.0km",
        "progress": "23.4km",
        "dDay": "13일 남음",
        "joined": true,
      },
      {
        "title": "6월 30K 챌린지",
        "desc": "이번 달 30km를 달려보세요.",
        "totalDistance": "30.0km",
        "progress": "12.0km",
        "dDay": "13일 남음",
        "joined": true,
      },
    ];

    final joinableChallenges = [
      {
        "title": "6월 주간 챌린지",
        "desc": "이번 주 5km를 달려보세요.",
        "totalDistance": "5.0km",
        "progress": "0.0km",
        "dDay": "5일 남음",
        "joined": false,
      },
      {
        "title": "6월 주간 챌린지",
        "desc": "이번 주 15km를 달려보세요.",
        "totalDistance": "15.0km",
        "progress": "0.0km",
        "dDay": "5일 남음",
        "joined": false,
      },
      {
        "title": "6월 주간 챌린지",
        "desc": "이번 주 10km를 달려보세요.",
        "totalDistance": "10.0km",
        "progress": "0.0km",
        "dDay": "5일 남음",
        "joined": false,
      },
      {
        "title": "6월 100K 챌린지",
        "desc": "이번 달 100km를 달려보세요.",
        "totalDistance": "100.0km",
        "progress": "0.0km",
        "dDay": "13일 남음",
        "joined": false,
      },
      {
        "title": "6월 25K 챌린지",
        "desc": "이번 달 25km를 달려보세요.",
        "totalDistance": "25.0km",
        "progress": "0.0km",
        "dDay": "13일 남음",
        "joined": false,
      },
      {
        "title": "6월 30K 챌린지",
        "desc": "이번 달 30km를 달려보세요.",
        "totalDistance": "30.0km",
        "progress": "0.0km",
        "dDay": "13일 남음",
        "joined": false,
      },
    ];

    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommunityDrawer(),
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
                  Text(
                    "챌린지",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF021F59),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                "images/challenge_banner.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChallengeCreatePage(),)
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "챌린지 만들기",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF021F59),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "나의 챌린지",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF021F59),
              ),
            ),
            const SizedBox(height: 8),
            ...buildChallengeCards(myChallenges, context),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "챌린지 참여하기",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF021F59),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "모두 보기",
                    style: TextStyle(color: Color(0xFF021F59)),
                  ),
                ),
              ],
            ),
            ...buildChallengeCards(joinableChallenges, context),
          ],
        ),
      ),
    );
  }

  List<Widget> buildChallengeCards(
    List<Map<String, Object>> challenges,
    BuildContext context,
  ) {
    return challenges.map((c) {
      final String title = c["title"] as String;
      final String dDay = c["dDay"] as String;
      final String desc = c["desc"] as String;
      final String totalDistance = c["totalDistance"] as String;
      final String progress = c["progress"] as String;
      final bool isJoined = c["joined"] as bool;

      return Card(
        color: const Color(0xFFF9FAEB),
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChallengeDetailPage(
                  title: title,
                  dDay: dDay,
                  progress: progress,
                  totalDistance: totalDistance,
                  desc: desc,
                  isJoined: isJoined,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                      "images/challenge_achievement.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF021F59),
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (!isJoined)
                        Text(
                          desc,
                          style: const TextStyle(color: Color(0xFF021F59)),
                        ),

                      // 진행률 (참여 중일 때만 표시)
                      if (isJoined)
                        Text(
                          "$progress / $totalDistance",
                          style: const TextStyle(color: Colors.blue),
                        ),

                      Text(
                        dDay,
                        style: const TextStyle(color: Color(0xFF021F59)),
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

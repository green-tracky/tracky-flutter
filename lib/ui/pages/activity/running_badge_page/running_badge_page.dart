import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/detail_page.dart';

class RunningBadgePage extends StatelessWidget {
  final List<Map<String, dynamic>> personalRecords = [
    {
      'title': '최장 거리 러닝',
      'date': '2025. 6. 17.',
      'record': '5.12km',
      'achieved': true,
      'isMine': true,
    },
    {
      'title': '최장 시간 러닝',
      'date': '2025. 6. 17.',
      'record': '01:02:12',
      'achieved': true,
      'isMine': true,
    },
    {
      'title': '1K 최고 기록',
      'achieved': false,
      'isMine': true,
    },
    {
      'title': '5K 최고 기록',
      'achieved': false,
      'isMine': true,
    },
  ];

  final List<Map<String, dynamic>> monthlyDistance = [
    {
      'title': '브론즈',
      'count': 2,
      'date': '2025. 5. 1.',
      'achieved': true,
    },
    {
      'title': '실버',
      'count': 0,
      'achieved': false,
    },
    {
      'title': '골드',
      'count': 0,
      'achieved': false,
    },
  ];

  final List<Map<String, dynamic>> challengeRecords = [
    {
      'title': '금메달',
      'count': 3,
      'date': '2025. 6. 20.',
      'achieved': true,
    },
    {
      'title': '은메달',
      'count': 1,
      'date': '2025. 5. 15.',
      'achieved': true,
    },
    {
      'title': '동메달',
      'count': 0,
      'achieved': false,
    },
    {
      'title': '완주',
      'count': 5,
      'date': '2025. 6. 30.',
      'achieved': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        title: const Text('달성 기록'),
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        },),
      ),
      backgroundColor: Color(0xFFF9FAEB),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('개인 기록'),
          _badgeGrid(personalRecords, isPersonal: true),
          const SizedBox(height: 24),
          _sectionTitle('월 러닝 거리'),
          _badgeGrid(monthlyDistance, isCountBased: true),
          const SizedBox(height: 24),
          _sectionTitle('챌린지 기록'),
          _badgeGrid(challengeRecords, isCountBased: true, isChallenge: true),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  Widget _badgeGrid(
    List<Map<String, dynamic>> items, {
    bool isPersonal = false,
    bool isCountBased = false,
    bool isChallenge = false,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        final achieved = item['achieved'] == true;
        final date = item['date'] as String?;
        final label = item['title'] as String;
        final record = item['record'] as String?;
        final count = item['count'] as int?;
        final isMine = item['isMine'] as bool? ?? false;

        Color iconColor = achieved ? Colors.black : Colors.grey.shade400;
        if (isChallenge && achieved) {
          switch (label) {
            case '금메달':
              iconColor = const Color(0xFFFFD700); // 금색
              break;
            case '은메달':
              iconColor = const Color(0xFFC0C0C0); // 은색
              break;
            case '동메달':
              iconColor = const Color(0xFFCD7F32); // 동색
              break;
            case _:
              iconColor = const Color(0xFFD0F252);
          }
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BadgeDetailPage(
                  title: label,
                  date: date ?? '',
                  imageAsset: !achieved
                      ? 'assets/images/tracky_badge_white.png'
                      : 'assets/images/tracky_badge_black.png',
                  badgeColor: achieved
                      ? (isChallenge ? iconColor : const Color(0xFFD0F252))
                      : Colors.black,
                  isMine: isMine,
                  isAchieved: achieved,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Container(
                width: 56,
                height: 56,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: achieved ? Colors.black : Colors.grey.shade400,
                  ),
                  shape: BoxShape.circle,
                  color: achieved
                      ? (isChallenge ? iconColor : const Color(0xFFD0F252))
                      : Colors.grey.shade200,
                ),
                child: ClipOval(
                  child: Transform.scale(
                    scale: 2,
                    child: Image.asset(
                      'assets/images/tracky_badge_black.png',
                      fit: BoxFit.cover,
                      color: achieved ? Colors.black : Colors.grey.shade400,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  achieved && date != null ? date! : '',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: achieved ? Colors.black : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (isPersonal)
                Text(record ?? '', style: const TextStyle(fontSize: 12))
              else if (isCountBased)
                Text(
                  count != null && count > 0 ? '$count개' : '',
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          ),
        );
      },
    );
  }
}

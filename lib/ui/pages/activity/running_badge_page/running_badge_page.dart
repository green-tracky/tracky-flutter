import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/widgets/running_badge.dart';

class RunningBadgePage extends StatelessWidget {

  // 데이터는 VM에서 받아와야 함
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
      appBar: _appBar(context),
      backgroundColor: AppColors.trackyBGreen,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('개인 기록'),
          _badgeGrid(personalRecords, isPersonal: true),
          Gap.xl,
          _sectionTitle('월 러닝 거리'),
          _badgeGrid(monthlyDistance, isCountBased: true),
          Gap.xl,
          _sectionTitle('챌린지 기록'),
          _badgeGrid(challengeRecords, isCountBased: true, isChallenge: true),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trackyBGreen,
      title: const Text('달성 기록', style: AppTextStyles.appBarTitle,),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      title,
      style: AppTextStyles.semiTitle,
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

        return RunningBadge(
          label: label,
          date: date,
          achieved: achieved,
          iconColor: iconColor,
          isMine: isMine,
          record: record,
          count: count,
          isPersonal: isPersonal,
          isCountBased: isCountBased,
          isChallenge: isChallenge,
        );
      },
    );
  }
}

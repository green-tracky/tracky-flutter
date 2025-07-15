import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/achieved_running_badge_list.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/running_card_icon.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/running_date.dart';

class RunningCard extends StatelessWidget {
  final int runId;
  final String date;
  final String dayTime;
  final String distance;
  final String pace;
  final String time;
  final List<String>? badges; // 수정됨

  const RunningCard({
    super.key,
    required this.runId,
    required this.date,
    required this.dayTime,
    required this.distance,
    required this.pace,
    required this.time,
    this.badges,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ActivityDetailPage(runId: runId),));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RunningCardIcon(),
                const SizedBox(width: 12),
                RunningDate(date: date, dayTime: dayTime),
              ],
            ),
            Gap.s,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dataColumn('$distance Km', '거리'),
                _dataColumn(pace, '평균 페이스'),
                _dataColumn(time, '시간'),
              ],
            ),
            if (badges != null && badges!.isNotEmpty) ...[
              Gap.s,
              const Divider(height: 1),
              AchievedRunningBadgeList(badgeNames: badges!), // 수정됨
            ],
          ],
        ),
      ),
    );
  }

  Widget _dataColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.content),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

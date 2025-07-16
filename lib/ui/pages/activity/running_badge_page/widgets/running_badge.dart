import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/detail_page.dart';

class RunningBadge extends StatelessWidget {
  const RunningBadge({
    super.key,
    required this.label,
    required this.date,
    required this.achieved,
    required this.iconColor,
    required this.isMine,
    required this.count,
    required this.isPersonal,
    required this.isCountBased,
    required this.isChallenge,
  });

  final String label;
  final String? date;
  final bool achieved;
  final Color iconColor;
  final bool isMine;
  final int? count;
  final bool isPersonal;
  final bool isCountBased;
  final bool isChallenge;

  @override
  Widget build(BuildContext context) {
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
            Text(date ?? '', style: const TextStyle(fontSize: 12))
          else if (isCountBased)
            Text(
              (count ?? 0) > 0 ? '$count개' : '',
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}

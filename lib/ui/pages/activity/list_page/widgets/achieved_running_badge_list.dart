import 'package:flutter/material.dart';

class AchievedRunningBadgeList extends StatelessWidget {
  final List<String> badgeNames;

  const AchievedRunningBadgeList({super.key, required this.badgeNames});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: badgeNames.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final name = badgeNames[index];
          final color = _getBadgeColor(name);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: ClipOval(
                    child: Transform.scale(
                      scale: 2,
                      child: Image.asset(
                        'assets/images/tracky_badge_black.png',
                        fit: BoxFit.cover,
                        color: Colors.black,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBadgeColor(String name) {
    switch (name) {
      case '금메달':
        return const Color(0xFFFFD700); // gold
      case '은메달':
        return const Color(0xFFC0C0C0); // silver
      case '동메달':
        return const Color(0xFFCD7F32); // bronze
      default:
        return const Color(0xFFD0F252); // 기본 색
    }
  }
}

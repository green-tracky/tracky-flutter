import 'package:flutter/material.dart';

class AchievedRunningBadgeList extends StatelessWidget {
  const AchievedRunningBadgeList({
    super.key,
    required this.badges,
  });

  final List<IconData>? badges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: badges!
            .map(
              (badge) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(badge, color: Colors.amber),
          ),
        )
            .toList(),
      ),
    );
  }
}

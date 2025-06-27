import 'package:flutter/material.dart';
import 'package:nike1/recent_widgets/recent_badges.dart';
import 'package:nike1/recent_widgets/recent_date.dart';
import 'package:nike1/recent_widgets/recent_record.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          children: [
            RecentDate(),
            SizedBox(height: 20),
            RecentRecord(),
            Divider(thickness: 1, color: Colors.grey[300]),
            RecentBadges(),
          ],
        ),
      ),
    );
  }
}

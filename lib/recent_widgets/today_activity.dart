import 'package:flutter/material.dart';
import 'package:nike1/recent_widgets/recent_date.dart';
import 'package:nike1/recent_widgets/recent_record.dart';

class TodayActivity extends StatelessWidget {
  const TodayActivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RecentDate(),
            SizedBox(height: 20),
            RecentRecord(),
          ],
        ),
      ),
    );
  }
}

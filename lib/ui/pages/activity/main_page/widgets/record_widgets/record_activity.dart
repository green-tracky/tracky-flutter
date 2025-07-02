import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_widgets/record_badges.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_widgets/record_date.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_widgets/record_record.dart';

class RecordActivity extends StatelessWidget {
  const RecordActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0), // ✅ Container의 속성
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0), // ✅ decoration 내부로 이동
        ),
        child: Column(
          children: [
            RecordDate(),
            SizedBox(height: 20),
            RecordRecord(),
            Divider(thickness: 1, color: Colors.grey[300]),
            RecordBadges(),
          ],
        ),
      ),
    );
  }
}

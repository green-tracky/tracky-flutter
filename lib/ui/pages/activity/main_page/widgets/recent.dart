import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/running_card.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/recent_widgets/recent_activity.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/recent_widgets/recent_to_all.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/recent_widgets/today_activity.dart';

class Recent extends StatelessWidget {
  const Recent({super.key});

  final List<Map<String, dynamic>> dummyData = const [
    {
      'date': '2021-07-14',
      'dayTime': '수요일 저녁 러닝',
      'distance': '5.01',
      'pace': "9'35''",
      'time': '48:03',
    },
    {
      'date': '2021-07-12',
      'dayTime': '월요일 저녁 러닝',
      'distance': '5.00',
      'pace': "13'35''",
      'time': '1:07:57',
      'badges': [Icons.emoji_events, Icons.timer],
    },
    {
      'date': '2021-07-11',
      'dayTime': '일요일 오후 러닝',
      'distance': '0.67',
      'pace': "11'13''",
      'time': '07:31',
    },
    {
      'date': '2021-07-04',
      'dayTime': '일요일 오후 러닝',
      'distance': '5.00',
      'pace': "8'26''",
      'time': '42:13',
    },
    {
      'date': '2021-08-01',
      'dayTime': '일요일 아침 러닝',
      'distance': '4.00',
      'pace': "7'30''",
      'time': '30:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RecentToAll(),
          Gap.s,
          ...dummyData.map((item) {
            return RunningCard(
              date: item['date'],
              dayTime: item['dayTime'],
              distance: item['distance'],
              pace: item['pace'],
              time: item['time'],
              badges: item['badges'],
            );
          }).toList(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/filter/filter.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/widgets/running_card.dart';

class RunningListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final runData = _buildRunData();

    // 월별 그룹핑
    final groupedByMonth = <String, List<Map<String, dynamic>>>{};
    for (var run in runData) {
      final monthKey = DateFormat('yyyy년 M월').format(run['parsedDate']);
      groupedByMonth.putIfAbsent(monthKey, () => []).add(run);
    }

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: _appBar(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: groupedByMonth.entries.map((entry) {
          final totalRuns = entry.value.length;
          final totalDistance = entry.value.fold<double>(
            0.0,
            (sum, run) => sum + run['distance'],
          );
          final totalSeconds = entry.value.fold<int>(
            0,
            (sum, run) => sum + _parseDuration(run['time']),
          );
          final avgPace = _formatPace(totalSeconds ~/ totalDistance);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.xl,
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap.s,
              Text(
                "러닝 $totalRuns회  ${totalDistance.toStringAsFixed(2)}km  $avgPace/km",
                style: const TextStyle(color: Colors.grey),
              ),
              Gap.l,
              ...entry.value.map(
                (run) => RunningCard(
                  date: DateFormat('yyyy. M. d.').format(run['parsedDate']),
                  dayTime: run['dayTime'],
                  distance: run['distance'].toStringAsFixed(2),
                  pace: run['pace'],
                  time: run['time'],
                  badges: run['badges'],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAEB),
      leading: const BackButton(color: Colors.black),
      title: const Text('모든 활동', style: TextStyle(color: Colors.black)),
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.black),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RunningFilterPage(),
              ),
            );

            if (result != null) {
              print('선택된 정렬 기준: ${result['sort']}');
              print('선택된 연도: ${result['year']}');
              // 이후 필터링 로직에 적용
            }
          },
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _buildRunData() {
    final rawData = [
      {
        'date': '2021-07-14',
        'dayTime': '수요일 저녁 러닝',
        'distance': 5.01,
        'pace': "9'35''",
        'time': '48:03',
      },
      {
        'date': '2021-07-12',
        'dayTime': '월요일 저녁 러닝',
        'distance': 5.00,
        'pace': "13'35''",
        'time': '1:07:57',
        'badges': const [Icons.emoji_events, Icons.timer],
      },
      {
        'date': '2021-07-11',
        'dayTime': '일요일 오후 러닝',
        'distance': 0.67,
        'pace': "11'13''",
        'time': '07:31',
      },
      {
        'date': '2021-07-04',
        'dayTime': '일요일 오후 러닝',
        'distance': 5.00,
        'pace': "8'26''",
        'time': '42:13',
      },
      {
        'date': '2021-08-01',
        'dayTime': '일요일 아침 러닝',
        'distance': 4.00,
        'pace': "7'30''",
        'time': '30:00',
      },
    ];

    return rawData.map((run) {
      run['parsedDate'] = DateTime.parse(run['date'] as String);
      return run;
    }).toList();
  }

  int _parseDuration(String time) {
    final parts = time.split(":");
    if (parts.length == 2) {
      return int.parse(parts[0]) * 60 + int.parse(parts[1]);
    } else {
      return int.parse(parts[0]) * 3600 +
          int.parse(parts[1]) * 60 +
          int.parse(parts[2]);
    }
  }

  String _formatPace(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return "${minutes.toString()}'${seconds.toString().padLeft(2, '0')}''";
  }
}

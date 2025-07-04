import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/filter/filter.dart';

class RunningListPage extends StatelessWidget {
  const RunningListPage({super.key});

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
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
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
      ),
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
              const SizedBox(height: 24),
              Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "러닝 $totalRuns회  ${totalDistance.toStringAsFixed(2)}km  $avgPace/km",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ...entry.value.map(
                (run) => _runCard(
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

  Widget _runCard({
    required String date,
    required String dayTime,
    required String distance,
    required String pace,
    required String time,
    List<IconData>? badges,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black54,
                  ),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0),
                    child: const Icon(
                      Icons.directions_run,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(dayTime, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dataColumn('$distance Km', '거리'),
                _dataColumn(pace, '평균 페이스'),
                _dataColumn(time, '시간'),
              ],
            ),
            if (badges != null) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: badges
                      .map(
                        (badge) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(badge, color: Colors.amber),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dataColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

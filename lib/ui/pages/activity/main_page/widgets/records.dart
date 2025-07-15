import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_card.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_widgets/record_to_all.dart';

class Records extends StatelessWidget {
  const Records({super.key});

  // 예시 데이터 (JSON의 data.recents 일부)
  final List<Map<String, dynamic>> recentRecords = const [
    {
      "id": 1,
      "name": "금메달",
      "description": "챌린지에서 1위를 달성하셨습니다!",
      "imageUrl": "https://example.com/rewards/gold.png",
      "type": "챌린지 수상자",
      "achievedAt": "2025-06-16 00:01:00",
    },
    {
      "id": 4,
      "name": "완주자",
      "description": "챌린지를 완료하셨습니다!",
      "imageUrl": "https://example.com/rewards/participation.png",
      "type": "챌린지 우승자",
      "achievedAt": "2025-06-14 10:00:00",
    },
    {
      "id": 1,
      "name": "첫 시작",
      "description": "매달 첫 러닝을 완료했어요!",
      "imageUrl": "https://example.com/badges/first_run.png",
      "type": "월간업적",
      "achievedAt": "2025-03-15 10:00:00",
    },
    {
      "id": 1,
      "name": "첫 시작",
      "description": "매달 첫 러닝을 완료했어요!",
      "imageUrl": "https://example.com/badges/first_run.png",
      "type": "월간업적",
      "achievedAt": "2025-02-15 10:00:00",
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
          const RecordToAll(),
          const SizedBox(height: 12),
          ...recentRecords.map((record) => RecordCard(record: record)).toList(),
        ],
      ),
    );
  }
}

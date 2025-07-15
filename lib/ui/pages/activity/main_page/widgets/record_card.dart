import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordCard extends StatelessWidget {
  final Map<String, dynamic> record;

  const RecordCard({super.key, required this.record});

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '0000. 00. 00';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy. MM. dd').format(date);
    } catch (e) {
      return '0000. 00. 00';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String type = record['type'] ?? '';
    final bool isChallenge = type.contains('챌린지');

    // 기본 아이콘 색상
    Color iconColor = Colors.grey.shade400;
    if (isChallenge) {
      switch (record['name']) {
        case '금메달':
          iconColor = const Color(0xFFFFD700);
          break;
        case '은메달':
          iconColor = const Color(0xFFC0C0C0);
          break;
        case '동메달':
          iconColor = const Color(0xFFCD7F32);
          break;
        default:
          iconColor = const Color(0xFFD0F252);
      }
    }

    return InkWell(
      onTap: () {
        debugPrint('Tapped: ${record['name']}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Row(
          children: [
            // 뱃지 스타일 아이콘 (대체된 부분)
            Container(
              width: 56,
              height: 56,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
                color: isChallenge ? iconColor : const Color(0xFFD0F252),
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record['name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(record['achievedAt']),
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}

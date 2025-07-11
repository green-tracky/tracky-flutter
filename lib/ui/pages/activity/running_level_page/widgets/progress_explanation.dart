import 'package:flutter/material.dart';

class ProgressExplanation extends StatelessWidget {
  const ProgressExplanation({
    super.key,
    required this.currentLevel,
    required this.totalKm,
    required this.levels,
    required this.remainingKm,
  });

  final int currentLevel;
  final double totalKm;
  final List<Map<String, dynamic>> levels;
  final double remainingKm;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          children: currentLevel == 6
              ? [
            const TextSpan(
              text: '총 달린 거리: ',
              style: TextStyle(fontSize: 16),
            ),
            TextSpan(
              text: '${totalKm.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF021F59),
              ),
            ),
            const TextSpan(
              text: ' km',
              style: TextStyle(fontSize: 16),
            ),
          ]
              : [
            TextSpan(
              text:
              '${levels[(currentLevel + 1).clamp(0, levels.length - 1)]['label']} 레벨까지 ',
              style: const TextStyle(fontSize: 16),
            ),
            TextSpan(
              text: '${remainingKm.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF021F59),
              ),
            ),
            const TextSpan(
              text: ' km 남았습니다.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

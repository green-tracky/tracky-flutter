import 'package:flutter/material.dart';

class MyRankingCard extends StatelessWidget {
  final int rank;
  final int totalDistanceMeters;

  const MyRankingCard({
    required this.rank,
    required this.totalDistanceMeters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 큰 총 거리 숫자
          Text(
            '${(totalDistanceMeters / 1000).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Km',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 18),
          // n번째위 달성
          Text(
            '${rank}위 달성',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RecentBadges extends StatelessWidget {
  const RecentBadges({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // ← 좌측 정렬
        children: [
          Image.asset(
            'assets/badge1.png',
            width: 40,
            height: 40,
          ),
          SizedBox(width: 16), // ← 간격 조절
          Image.asset(
            'assets/badge2.png',
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}

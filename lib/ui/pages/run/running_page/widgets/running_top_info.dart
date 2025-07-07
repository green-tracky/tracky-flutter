import 'package:flutter/material.dart';

class TopInfo extends StatelessWidget {
  final String pace;
  final String time;

  const TopInfo({super.key, required this.pace, required this.time});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 페이스 표시
            Column(
              children: [
                Text(
                  pace,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '페이스',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF021F59),
                  ),
                ),
              ],
            ),

            // 시간 표시
            Column(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '시간',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF021F59),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

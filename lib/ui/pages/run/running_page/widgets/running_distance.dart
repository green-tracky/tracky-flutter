import 'package:flutter/material.dart';

class DistanceDisplay extends StatelessWidget {
  const DistanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.3), // 적절한 위치로 이동
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '0.00',
            style: TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
          Text('킬로미터', style: TextStyle(fontSize: 25, color: Color(0xFF021F59))),
        ],
      ),
    );
  }
}

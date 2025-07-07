import 'package:flutter/material.dart';

class RunningDistanceDisplay extends StatelessWidget {
  final String distance;

  const RunningDistanceDisplay({super.key, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            distance,
            style: TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
          Text(
            '킬로미터',
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFF021F59),
            ),
          ),
        ],
      ),
    );
  }
}

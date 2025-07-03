import 'package:flutter/material.dart';

class RecordToAll extends StatelessWidget {
  const RecordToAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "달성 기록",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

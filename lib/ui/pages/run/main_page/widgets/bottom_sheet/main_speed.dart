import 'package:flutter/material.dart';

Widget buildSpeedGoal(BuildContext context) {
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.10,
    left: 0,
    right: 0,
    child: const Center(
      child: Text(
        '러닝 중 랩을\n기록하세요',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

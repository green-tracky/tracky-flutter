import 'package:flutter/material.dart';

class RunMainTitle extends StatelessWidget {
  const RunMainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        '러닝',
        style: TextStyle(
          fontSize: 30, // pageTitle
          fontWeight: FontWeight.bold,
          color: Color(0xFF021F59),
        ),
      ),
    );
  }
}
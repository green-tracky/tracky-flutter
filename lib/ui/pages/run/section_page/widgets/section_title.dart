import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        '구간',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Color(0xFF021F59),
        ),
      ),
    );
  }
}
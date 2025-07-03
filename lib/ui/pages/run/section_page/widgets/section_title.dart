import 'package:flutter/material.dart';

class RunSectionTitle extends StatelessWidget {
  const RunSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
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

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

class StartRunButton extends StatelessWidget {
  const StartRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 150,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RunRunningPage()),
            );
          },
          borderRadius: BorderRadius.circular(60),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFD0F252), // trackyNeon
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '시작',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF021F59), // trackyIndigo
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
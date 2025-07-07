import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

class ResumeRunButton extends StatelessWidget {
  const ResumeRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RunRunningPage()),
        );
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Color(0xFFD0F252), // trackyNeon
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';

class NoRunRecordPage extends StatelessWidget {
  const NoRunRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => RunMainPage()),
                      (route) => false,
                ),
              ),
            ),

            Center(
              child: Text(
                '러닝 기록이 없습니다',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AcitivityButton extends StatelessWidget {
  const AcitivityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/allActivities');
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: StadiumBorder(), // 버튼 모양을 둥글게
        backgroundColor: Colors.transparent, // 원하는 색상으로 변경
      ),
      child: Text('모든 활동', style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}

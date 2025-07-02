import 'package:flutter/material.dart';

class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key});

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
      child: Text('모두보기', style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}

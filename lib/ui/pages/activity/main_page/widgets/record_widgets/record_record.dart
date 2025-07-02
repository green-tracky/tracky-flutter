import 'package:flutter/material.dart';

class RecordRecord extends StatelessWidget {
  const RecordRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2, // 첫 번째 칼럼 (Km)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("0.15", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Km", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Expanded(
          flex: 2, // 두 번째 칼럼 (평균 페이스)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("14'11''", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("평균 페이스", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        Expanded(
          flex: 4, // 세 번째 칼럼 (시간)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("02:12", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("시간", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }


}
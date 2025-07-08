import 'package:flutter/material.dart';

class RecordDate extends StatelessWidget {
  const RecordDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          child: Image.asset("assets/images/run1.png", fit: BoxFit.cover),
        ),
        Container(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("오늘"), Text("월요일 오전")],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nike1/records.dart';

import 'recent.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF9FAEB),
      child: ListView(
        children: [
          SizedBox(height: 100),
          Recent(),
          Records(),
        ],
      ),
    );
  }
}



class FullActivityPage {}

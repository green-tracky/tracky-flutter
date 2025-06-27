import 'package:flutter/material.dart';
import 'package:nike1/recent_widgets/recent_activity.dart';
import 'package:nike1/recent_widgets/recent_to_all.dart';
import 'package:nike1/recent_widgets/today_activity.dart';
import 'package:nike1/record_widgets/record_activity.dart';
import 'package:nike1/record_widgets/record_to_all.dart';
import 'package:nike1/record_widgets/today_record_activity.dart';


class Records extends StatelessWidget {
  const Records({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white54, // 필요 시 전체 배경 컬러 설정
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RecordToAll(),
          RecordActivity(),
          TodayRecordActivity(),
        ],
      ),
    );
  }
}



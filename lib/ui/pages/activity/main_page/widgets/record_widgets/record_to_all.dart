import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/running_badge_page.dart';

class RecordToAll extends StatelessWidget {
  const RecordToAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "달성 기록",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black38,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
                      onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RunningBadgePage(),));
                      },
                      child: Text(
          "전체보기 >",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
                      ),
                    ),
          
        ],
      ),
    );
  }
}

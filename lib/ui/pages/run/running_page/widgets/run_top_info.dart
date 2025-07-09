import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunTopInfo extends StatelessWidget {
  const RunTopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 30,
      right: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽: 페이스
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "_'__\"",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text('페이스', style: TextStyle(fontSize: 16, color: AppColors.trackyIndigo)),
            ],
          ),

          // 오른쪽: 시간
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "00:08",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text('시간', style: TextStyle(fontSize: 16, color: AppColors.trackyIndigo)),
            ],
          ),
        ],
      ),
    );
  }
}

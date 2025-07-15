import 'package:flutter/material.dart';

class IconColumn extends StatelessWidget {
  const IconColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite_border, // 하트 아이콘
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(
                    height: 10,
                  ), // 아이콘과 텍스트 간 간격
                  Text(
                    '영양 및 웰니스 팁',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.podcasts, // 하트 아이콘
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(
                    height: 10,
                  ), // 아이콘과 텍스트 간 간격
                  Text(
                    '오디오 가이드 런 및 음악',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40,),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_box_rounded, // 하트 아이콘
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(
                    height: 10,
                  ), // 아이콘과 텍스트 간 간격
                  Text(
                    '유연한 운동 일정',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.mark_chat_unread_rounded, // 하트 아이콘
                    color: Colors.grey,
                    size: 16,
                  ),
                  SizedBox(
                    height: 10,
                  ), // 아이콘과 텍스트 간 간격
                  Text(
                    '동기 부여 및 진행 상황\n 업데이트',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
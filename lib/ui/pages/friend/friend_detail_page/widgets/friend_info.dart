import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class DetailFriendInfoBox extends StatelessWidget {
  const DetailFriendInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '활동지역 및 거주지',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Gap.s,
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '서울특별시 마포구',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        Gap.xl,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '자기소개',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const Text(
              '0/150',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Gap.m,
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '러닝과 커피를 좋아하는 사람입니다.\n주말엔 한강에서 자주 달립니다!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

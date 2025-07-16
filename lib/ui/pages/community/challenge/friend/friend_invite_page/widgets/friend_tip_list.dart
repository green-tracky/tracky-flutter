import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class InviteFriendTipList extends StatelessWidget {
  const InviteFriendTipList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 검색 아이템
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.search, color: Colors.black),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '추가할 친구 찾기',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),

        Gap.l,

        // 초대 설명 아이템
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 아이콘을 정렬 고정하고 패딩 추가
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person_add_alt, color: Colors.black),
            ),

            Gap.m, // 아이콘과 텍스트 사이 간격 확보

            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '친구 요청이 수락되면 나의 챌린지로 \n친구를 초대할 수 있습니다.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// challenge_detail_friend_header.dart
import 'package:flutter/material.dart';

class ChallengeDetailFriendHeader extends StatelessWidget {
  final String name;
  final bool isFriend; // 이 속성은 친구 여부를 판단하여 초대 버튼만 표시할지 여부를 결정합니다.
  final VoidCallback? onAdd; // 챌린지 초대 버튼의 콜백 (null일 수 있음)
  final bool isChallengeInvited; // 챌린지 초대 요청이 되었는지 여부

  const ChallengeDetailFriendHeader({
    super.key,
    required this.name,
    required this.isFriend,
    this.onAdd, // 선택 사항
    this.isChallengeInvited = false, // 기본값은 false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 아바타/프로필 사진과 같은 기존 헤더 위젯들을 여기에 포함할 수 있습니다.
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey, // 임시 아바타 배경색
          child: Icon(Icons.person, size: 60, color: Colors.white), // 임시 아바타 아이콘
        ),
        const SizedBox(height: 20),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isFriend) // 친구가 아닐 때만 챌린지 초대 버튼 표시
              ElevatedButton(
                onPressed: onAdd, // onAdd가 null이면 버튼이 비활성화됩니다.
                style: ElevatedButton.styleFrom(
                  backgroundColor: isChallengeInvited ? Colors.grey : Colors.blueAccent, // 초대 요청 시 색상 변경
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(isChallengeInvited ? '요청됨' : '초대'), // 상태에 따라 텍스트 변경
              ),
            // isFriend가 true일 경우 여기에 다른 버튼 (예: 채팅 시작 등)을 추가할 수 있습니다.
            // 현재는 친구 삭제 로직이 없으므로, isFriend가 true이면 버튼이 표시되지 않습니다.
          ],
        ),
      ],
    );
  }
}
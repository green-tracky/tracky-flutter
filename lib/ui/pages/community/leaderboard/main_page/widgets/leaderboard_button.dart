import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_invite_page/friend_invite_page.dart';

class LeaderboardInviteButton extends StatelessWidget {
  const LeaderboardInviteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => InviteFriendPage()),
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.trackyNeon,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text('친구 찾기 및 초대'),
      ),
    );
  }
}

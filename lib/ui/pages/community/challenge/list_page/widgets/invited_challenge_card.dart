import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/invite_page/invite_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/challenge_list_vm.dart';

class InvitedChallengeCard extends StatelessWidget {
  const InvitedChallengeCard({
    super.key,
    required this.invitedChallenge,
  });

  final InviteChallenge invitedChallenge;

  @override
  Widget build(BuildContext context) {
    final String name = invitedChallenge.challengeInfo.name;
    final String? imageUrl = invitedChallenge.challengeInfo.imageUrl;
    final String inviter = invitedChallenge.fromUsername;
    final int dDay = (invitedChallenge.challengeInfo.remainingTime / 86400).floor();
    final String daysLeft = dDay > 0 ? "$dDay일 남음" : "마감됨";

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFFF9FAEB),
      elevation: 2,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChallengeInvitePage(),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: /* imageUrl != null && imageUrl.isNotEmpty
              ? NetworkImage(imageUrl)
              :  */const AssetImage("assets/images/challenge_invitation.png"),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        subtitle: Text(
          "$inviter 님이 초대했습니다\n$daysLeft",
          style: const TextStyle(fontSize: 12),
        ),
        isThreeLine: true,
        trailing: const SizedBox(
          width: 24,
          height: 100,
          child: Center(
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Color(0xFF021F59),
            ),
          ),
        ),
      ),
    );
  }
}

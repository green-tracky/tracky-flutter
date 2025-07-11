import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/challenge_list_vm.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/widgets/invited_challenge_card.dart';

class ChallengeInvitationBody extends StatelessWidget {
  const ChallengeInvitationBody({
    super.key,
    required this.inviteChallenges,
  });

  final List<InviteChallenge> inviteChallenges;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap.m,
        const Text(
          "초대",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
            fontSize: 18,
          ),
        ),
        ...inviteChallenges.map((invite) => InvitedChallengeCard(invitedChallenge: invite)).toList(),
      ],
    );
  }
}

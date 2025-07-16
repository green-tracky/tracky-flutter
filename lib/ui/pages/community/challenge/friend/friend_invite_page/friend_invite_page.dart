import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_invite_page/widgets/frend_button.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_invite_page/widgets/friend_tip_list.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_invite_page/widgets/friend_title.dart';

class InviteFriendPage extends StatelessWidget {
  const InviteFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '친구 초대하기',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Gap.xl,
            InviteFriendTitle(),
            Gap.l,
            InviteFriendTipList(),
          ],
        ),
      ),
      bottomNavigationBar: const InviteFriendButton(),
    );
  }
}

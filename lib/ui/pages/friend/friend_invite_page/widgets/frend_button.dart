import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/friend_add_page.dart';

class InviteFriendButton extends StatelessWidget {
  const InviteFriendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddFriendPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.trackyNeon,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '친구 추가',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF021F59),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

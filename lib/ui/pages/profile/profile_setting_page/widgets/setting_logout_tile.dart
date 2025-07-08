import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_setting_page/setting_logout_page/logout_confirm_dialog.dart';

class SectionLogoutTile extends StatelessWidget {
  const SectionLogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "로그아웃",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.trackyIndigo,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => LogoutConfirmDialog(),
        );
      },
    );
  }
}

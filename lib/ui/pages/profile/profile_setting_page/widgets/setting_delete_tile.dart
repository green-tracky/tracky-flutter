import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_setting_page/setting_delete_page/first_delete_warning_page.dart';

class SectionDeleteAccountTile extends StatelessWidget {
  const SectionDeleteAccountTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "계정 삭제",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.trackyIndigo,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.trackyIndigo),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FirstDeleteWarningPage()),
        );
      },
    );
  }
}

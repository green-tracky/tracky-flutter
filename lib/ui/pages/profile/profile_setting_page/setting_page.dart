import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_setting_page/widgets/setting_delete_tile.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_setting_page/widgets/setting_logout_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        title: Text(
          "설정",
          style: TextStyle(
            color: AppColors.trackyIndigo,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.trackyIndigo),
      ),
      body: Column(
        children: [
          SectionDeleteAccountTile(),
          Divider(height: 1, color: Colors.grey),
          SectionLogoutTile(),
        ],
      ),
    );
  }
}

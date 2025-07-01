import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/profile/widgets/first_delete_warning_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        title: Text("설정", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("계정 삭제"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FirstDeleteWarningPage()),
              );
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Text("로그아웃"),
            onTap: () {
              // TODO: 로그아웃 로직
            },
          ),
        ],
      ),
    );
  }
}

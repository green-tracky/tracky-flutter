import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LeaderboardView());
  }
}

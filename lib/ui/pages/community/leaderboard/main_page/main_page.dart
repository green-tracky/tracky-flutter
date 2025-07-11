import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/main_page/widgets/leaderboard_button.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

import 'widgets/leaderboard_background.dart';
import 'widgets/leaderboard_description.dart';
import 'widgets/leaderboard_title.dart';

class LeaderboardMainPage extends StatelessWidget {
  const LeaderboardMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: CommonAppBar(),
      endDrawer: CommunityDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeaderboardTitle(),
          Expanded(
            child: LeaderboardBackground(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    LeaderboardDescription(),
                    Gap.l,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: LeaderboardInviteButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

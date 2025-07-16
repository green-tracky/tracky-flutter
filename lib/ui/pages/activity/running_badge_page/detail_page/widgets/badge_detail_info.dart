import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/badge_image.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/badge_info.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/badge_title.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/latest_date.dart';

class BadgeDetailInfo extends StatelessWidget {
  const BadgeDetailInfo({
    super.key,
    required this.imageAsset,
    required this.isAchieved,
    required this.date,
    required this.title,
    required this.subtitle,
  });

  final String? imageAsset;
  final bool isAchieved;
  final String date;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageAsset != null)
          BadgeImage(isAchieved: isAchieved, imageAsset: imageAsset),
        Gap.xxl,
        LatestDate(date: date, isAchieved: isAchieved),
        Gap.s,
        BadgeTitle(title: title, isAchieved: isAchieved),
        Gap.s,
        BadgeInfo(subtitle: subtitle, isAchieved: isAchieved),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/badge_detail_info.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/badge_menu_button.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/widgets/badge_pop_button.dart';

class BadgeDetailPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  final String? imageAsset;
  final Color? badgeColor;
  final bool isMine;
  final bool isAchieved;

  const BadgeDetailPage({
    super.key,
    required this.title,
    this.subtitle,
    required this.date,
    this.imageAsset,
    this.badgeColor,
    required this.isMine,
    required this.isAchieved,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = badgeColor ?? Colors.black;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              // 중앙 콘텐츠
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: BadgeDetailInfo(imageAsset: imageAsset, isAchieved: isAchieved, date: date, title: title, subtitle: subtitle),
                ),
              ),

              // 좌측 상단 메뉴
              if (isMine && isAchieved)
                Positioned(
                  top: 12,
                  left: 12,
                  child: BadgeMenuButton(isAchieved: isAchieved),
                ),

              // 우측 상단 닫기 버튼
              Positioned(
                top: 12,
                right: 12,
                child: BadgePopButton(isAchieved: isAchieved),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







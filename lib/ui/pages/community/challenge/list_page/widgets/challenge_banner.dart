import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class ChallengeBanner extends StatelessWidget {
  const ChallengeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ 비율 유지하면서 이미지 출력
            AspectRatio(
              aspectRatio: 2,
              child: Container(
                color: AppColors.trackyNeon, // 여기에 원하는 배경색 지정
                width: double.infinity,
                child: Transform.scale(
                  scale: 1.5,
                  child: Image.asset(
                    "assets/images/tracky_badge_black.png",
                    fit: BoxFit.contain, // 로고는 cover보단 contain이 일반적
                  ),
                ),
              ),
            ),
            // ✅ 이미지 아래 텍스트
            Container(
              color: AppColors.trackyNeon, // 원하는 배경색
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                "지금 챌린지에 참여하여 목표를 달성하세요.",
                textAlign: TextAlign.center,
                style: AppTextStyles.semiTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class DeleteSuccessPage extends StatelessWidget {
  const DeleteSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "삭제되었습니다.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.trackyIndigo,
                ),
              ),
              Gap.l,
              Text(
                "계정과 관련된 모든 데이터가 삭제되었습니다.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.trackyIndigo,
                ),
                textAlign: TextAlign.center,
              ),
              Gap.xl,
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.trackyNeon,
                  foregroundColor: AppColors.trackyIndigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: Text(
                  "회원가입 화면으로 이동",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.trackyIndigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

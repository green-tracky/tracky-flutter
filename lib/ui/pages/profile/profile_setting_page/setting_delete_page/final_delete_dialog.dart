import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/profile/profile_setting_page/setting_delete_page/delete_succes_page.dart';

class FinalDeleteDialog extends StatelessWidget {
  const FinalDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "정말 삭제하시겠습니까?",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.trackyIndigo,
        ),
      ),
      content: Text(
        "사용자가 완전히 삭제됩니다.\n정말 삭제하시겠습니까?",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppColors.trackyIndigo,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "취소",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.trackyOKBlue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // 다이얼로그 닫기
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DeleteSuccessPage()),
            );
          },
          child: Text(
            "삭제",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.trackyCancelRed,
            ),
          ),
        ),
      ],
    );
  }
}

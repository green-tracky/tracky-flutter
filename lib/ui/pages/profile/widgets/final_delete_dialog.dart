import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/profile/widgets/delete_succes_page.dart';

class FinalDeleteDialog extends StatelessWidget {
  const FinalDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("정말 삭제하시겠습니까?"),
      content: Text("사용자가 완전히 삭제됩니다.\n정말 삭제하시겠습니까?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("취소", style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // 닫기
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DeleteSuccessPage()),
            );
          },
          child: Text("삭제", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}

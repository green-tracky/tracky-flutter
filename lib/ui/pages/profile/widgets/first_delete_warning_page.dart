import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/profile/widgets/final_delete_dialog.dart';

class FirstDeleteWarningPage extends StatelessWidget {
  const FirstDeleteWarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "정말 삭제하시겠습니까?",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Text(
              "삭제 시 모든 정보가 사라집니다.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFF021F59),
                      side: BorderSide(color: Color(0xFF021F59)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text("취소"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => FinalDeleteDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD0F252),
                      foregroundColor: Color(0xFF021F59),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: Text("삭제"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

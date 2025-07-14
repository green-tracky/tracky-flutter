import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/create_page/create_page.dart';

class CreateChallengeButton extends StatelessWidget {
  const CreateChallengeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChallengeCreatePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(200, 50),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          "챌린지 만들기",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
      ),
    );
  }
}
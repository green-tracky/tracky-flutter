import 'package:flutter/material.dart';

class RunningButton extends StatelessWidget {
  const RunningButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD0F252),
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/running');
        },
        child: const Text(
          "러닝 시작하기",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF021F59)
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class JoinButton extends StatelessWidget {
  final VoidCallback onPressed;

  const JoinButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: const Text('계속하기', style: AppTextStyles.semiTitle),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChallengeBanner extends StatelessWidget {
  const ChallengeBanner({
    super.key,
  });

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
        child: Image.asset(
          "assets/images/challenge_banner.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: 180,
        ),
      ),
    );
  }
}
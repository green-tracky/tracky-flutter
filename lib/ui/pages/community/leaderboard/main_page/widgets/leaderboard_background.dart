import 'package:flutter/material.dart';

class LeaderboardBackground extends StatelessWidget {
  final Widget child;

  const LeaderboardBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/run_1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withAlpha(135),
        ),
        child,
      ],
    );
  }
}

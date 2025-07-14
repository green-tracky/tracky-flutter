import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/widgets/common_title.dart';

class ChallengeTitle extends StatelessWidget {
  const ChallengeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonTitle(
            title: "챌린지",
          ),
        ],
      ),
    );
  }
}
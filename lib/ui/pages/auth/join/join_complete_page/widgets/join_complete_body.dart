import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/auth/join/join_complete_page/widgets/join_complete_info.dart';
import 'package:tracky_flutter/ui/pages/auth/join/join_complete_page/widgets/running_button.dart';

class JoinCompleteBody extends StatelessWidget {
  const JoinCompleteBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Gap.ss,
        JoinCompleteInfo(),
        RunningButton(),
      ],
    );
  }
}
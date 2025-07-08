// main_appbar.dart
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const RunMainAppBar({Key? key}) : preferredSize = const Size.fromHeight(90), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trackyBGreen,
      elevation: 0,
      toolbarHeight: 90,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: const CircleAvatar(
                radius: 21,
                backgroundColor: AppColors.trackyIndigo,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

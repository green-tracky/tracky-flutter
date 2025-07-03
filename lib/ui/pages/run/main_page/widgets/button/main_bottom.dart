import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/bottom_sheet/main_goal_type.dart';

Positioned buildbottombutton(BuildContext context, WidgetRef ref) {
  return Positioned(
    bottom: 60,
    left: 0,
    right: 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            showGoalSettingBottomSheet(context, ref);
          },
          icon: Icon(Icons.flag, color: Colors.black, size: 25),
          label: Text("목표설정", style: TextStyle(color: Colors.black, fontSize: 18)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 2,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            minimumSize: Size(120, 50),
          ),
        ),
      ],
    ),
  );
}

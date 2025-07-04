import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeMenuButton extends StatelessWidget {
  const BadgeMenuButton({
    super.key,
    required this.isAchieved,
  });

  final bool isAchieved;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.ellipsis),
      color: !isAchieved ? Colors.white : Colors.black,
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  debugPrint("러닝 이동");
                },
                child: const Text("러닝 이동", style: TextStyle(color: Colors.blue),),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text("취소", style: TextStyle(color: Colors.blue),),
            ),
          ),
        );
      },
    );
  }
}
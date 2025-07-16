import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

IconButton buildIconButton(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.more_horiz, color: Colors.black),
    onPressed: () {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
          title: Text("러닝 기록"),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              isDestructiveAction: true,
              child: Text("삭제"),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text("취소"),
          ),
        ),
      );
    },
  );
}

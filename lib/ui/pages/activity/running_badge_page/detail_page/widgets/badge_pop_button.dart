import 'package:flutter/material.dart';

class BadgePopButton extends StatelessWidget {
  const BadgePopButton({
    super.key,
    required this.isAchieved,
  });

  final bool isAchieved;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close_rounded),
      color: !isAchieved ? Colors.white : Colors.black,
      onPressed: () => Navigator.pop(context),
    );
  }
}
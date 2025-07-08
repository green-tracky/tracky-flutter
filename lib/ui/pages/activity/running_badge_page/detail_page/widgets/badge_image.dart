import 'package:flutter/material.dart';

class BadgeImage extends StatelessWidget {
  const BadgeImage({
    super.key,
    required this.isAchieved,
    required this.imageAsset,
  });

  final bool isAchieved;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: !isAchieved ? Colors.white : Colors.black,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: ClipOval(
        child: Transform.scale(
          scale: 2,
          child: Image.asset(
            imageAsset!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
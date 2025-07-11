import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class DetailFriendHeader extends StatelessWidget {
  final String name;
  final bool isFriend;
  final VoidCallback onDelete;
  final VoidCallback onAdd;

  const DetailFriendHeader({
    super.key,
    required this.name,
    required this.isFriend,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: Colors.grey.shade400,
          child: const Icon(Icons.person, size: 48, color: Colors.white),
        ),
        Gap.m,
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        Gap.l,
        isFriend
            ? ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black),
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 18),
                    Gap.s,
                    Text(
                      '친구',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            : ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.trackyNeon,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.black),
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                ),
                child: const Text(
                  '친구 추가',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
      ],
    );
  }
}

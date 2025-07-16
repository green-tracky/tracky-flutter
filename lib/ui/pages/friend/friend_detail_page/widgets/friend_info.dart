import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class DetailFriendInfoBox extends StatelessWidget {
  final String location;
  final String letter;

  const DetailFriendInfoBox({
    super.key,
    required this.location,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('활동지역 및 거주지', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        Gap.s,
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(location, style: TextStyle(fontSize: 14, color: Colors.black)),
        ),
        Gap.xl,
        Text('자기소개', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        Gap.m,
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(letter, style: TextStyle(fontSize: 14, color: Colors.black)),
        ),
      ],
    );
  }
}

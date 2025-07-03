import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSectionRow extends StatelessWidget {
  final RunSection section;

  const RunSectionRow({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${section.kilometer} km', style: const TextStyle(fontSize: 18, color: Color(0xFF021F59))),
          Text(section.pace, style: const TextStyle(fontSize: 18, color: Color(0xFF021F59))),
          Text('${section.variation}', style: const TextStyle(fontSize: 18, color: Color(0xFF021F59))),
        ],
      ),
    );
  }
}

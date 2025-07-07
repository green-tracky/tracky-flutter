import 'package:flutter/material.dart';

class SectionData {
  final int kilometer;
  final String pace;
  final double variation;

  SectionData({required this.kilometer, required this.pace, required this.variation});
}

class SectionListView extends StatelessWidget {
  final List<SectionData> sections;

  const SectionListView({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${section.kilometer} km', style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
                Text(section.pace, style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
                Text('${section.variation}', style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
              ],
            ),
          );
        },
      ),
    );
  }
}
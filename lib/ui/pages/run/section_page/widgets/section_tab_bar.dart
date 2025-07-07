import 'package:flutter/material.dart';

class SectionTabMenu extends StatelessWidget {
  final List<String> tabs;
  final void Function(String) onTabSelected;

  const SectionTabMenu({
    super.key,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs
            .map(
              (label) => GestureDetector(
            onTap: () => onTabSelected(label),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF021F59),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}

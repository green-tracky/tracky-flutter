import 'package:flutter/material.dart';

class RunSectionTabBar extends StatelessWidget {
  const RunSectionTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _TabItem(label: '킬로미터'),
          _TabItem(label: '페이스'),
          _TabItem(label: '편차'),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;

  const _TabItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black54,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

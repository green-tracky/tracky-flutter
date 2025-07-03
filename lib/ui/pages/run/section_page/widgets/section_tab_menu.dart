import 'package:flutter/material.dart';

class RunSectionTabMenu extends StatelessWidget {
  const RunSectionTabMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '킬로미터',
            style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w700),
          ),
          Text(
            '페이스',
            style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w700),
          ),
          Text(
            '편차',
            style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

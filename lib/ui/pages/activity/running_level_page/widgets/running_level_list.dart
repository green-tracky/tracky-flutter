import 'package:flutter/material.dart';

class RunningLevelList extends StatelessWidget {
  const RunningLevelList({
    super.key,
    required this.levels,
    required this.currentLevel,
  });

  final List<Map<String, dynamic>> levels;
  final int currentLevel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          final reached = index <= currentLevel;
          return ListTile(
            leading: Icon(
              Icons.shield,
              color: reached ? level['color'] : Colors.grey[400],
            ),
            title: Text(
              level['label'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: reached ? Colors.black : Colors.grey,
              ),
            ),
            subtitle: Text(
              level['range'],
              style: TextStyle(
                color: reached ? Colors.black54 : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/model/activity.dart';

class SurfaceSelectSheet extends StatelessWidget {
  final void Function(RunningSurface) onSelect;

  const SurfaceSelectSheet({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text('러닝 장소', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 12),
            Text('어느 곳에서 달리셨나요?', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: RunningSurface.values.map((surface) {
                return GestureDetector(
                  onTap: () => onSelect(surface),
                  child: Column(
                    children: [
                      Icon(getSurfaceIcon(surface), size: 40, color: Color(0xFF021F59)),
                      SizedBox(height: 8),
                      Text(getSurfaceLabel(surface), style: TextStyle(color: Colors.black)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

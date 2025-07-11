import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    super.key,
    required Animation<double> animation,
    required this.levels,
    required this.currentLevel,
  }) : _animation = animation;

  final Animation<double> _animation;
  final List<Map<String, dynamic>> levels;
  final int currentLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 50,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final progress = _animation.value;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: levels[currentLevel]['color'],
                      minHeight: 8,
                    ),
                  ),
                ),
                Positioned(
                  left: 24 + (MediaQuery.of(context).size.width - 48) * progress - 10,
                  top: -2,
                  child: Transform.rotate(
                    angle: pi,
                    child: const Icon(
                      Icons.navigation,
                      size: 20,
                      color: Color(0xFF021F59),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

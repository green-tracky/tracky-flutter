import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page.dart';

class RunPauseButton extends StatelessWidget {
  const RunPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 230,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RunPausedPage()),
            );
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: const Icon(Icons.pause, color: Colors.white, size: 36),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page.dart';

class PauseRunButton extends StatelessWidget {
  const PauseRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 230,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RunPausedPage()),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.pause, color: Colors.white, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}

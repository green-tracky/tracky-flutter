import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  final VoidCallback onTap;

  const PauseButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          child: Icon(Icons.pause, color: Colors.white, size: 36),
        ),
      ),
    );
  }
}

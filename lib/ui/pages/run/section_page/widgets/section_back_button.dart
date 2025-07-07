import 'package:flutter/material.dart';

class SectionBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SectionBackButton({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80.0),
      child: Center(
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD0F252),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            minimumSize: Size(120, 50),
            elevation: 2,
          ),
          icon: Icon(Icons.arrow_back, color: Colors.black),
          label: Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
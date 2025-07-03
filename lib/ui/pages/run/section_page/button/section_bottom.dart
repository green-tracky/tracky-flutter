import 'package:flutter/material.dart';

class RunSectionBottomButton extends StatelessWidget {
  const RunSectionBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD0F252),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            minimumSize: const Size(120, 50),
            elevation: 2,
          ),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          label: const Text('00:42', style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
      ),
    );
  }
}

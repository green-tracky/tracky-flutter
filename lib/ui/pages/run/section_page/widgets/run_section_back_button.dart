import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunSectionBackButton extends StatelessWidget {
  const RunSectionBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.trackyNeon,
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

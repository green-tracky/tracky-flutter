import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onMapTap;

  const BottomButtons({super.key, required this.onCameraTap, required this.onMapTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
      children: [
        // 📷 카메라 버튼
        SizedBox(
          width: 60,
          height: 60,
          child: ElevatedButton(
            onPressed: onCameraTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
          ),
        ),

        const SizedBox(width: 120), // 간격조절
        // 🗺️ 지도 버튼
        SizedBox(
          width: 60,
          height: 60,
          child: ElevatedButton(
            onPressed: onMapTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.map, color: Colors.white, size: 30),
          ),
        ),
      ],
    );
  }
}

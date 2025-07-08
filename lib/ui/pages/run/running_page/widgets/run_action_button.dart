import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/run_camera_screen.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/run_full_map.dart';

class RunActionButton extends StatelessWidget {
  const RunActionButton({super.key});

  void onCameraPressed(BuildContext context) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen(camera: firstCamera)));
  }

  void onSectionPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const FullMapPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _circleButton(Icons.camera_alt, () => onCameraPressed(context)),
          _circleButton(Icons.map, () => onSectionPressed(context)),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}

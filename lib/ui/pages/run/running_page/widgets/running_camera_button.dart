import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_camera_screen.dart';

class CameraActionButton extends StatelessWidget {
  const CameraActionButton({super.key});

  Future<void> _openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraScreen(camera: firstCamera),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      right: 30,
      child: InkWell(
        onTap: () => _openCamera(context),
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}

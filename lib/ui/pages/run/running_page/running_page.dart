import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/button/running_bottom.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/button/running_pause.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_camera.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_distance.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_info.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_map.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page.dart';

class RunRunningPage extends StatelessWidget {
  const RunRunningPage({super.key});

  void onPausePressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RunPausedPage()));
  }

  void onCameraPressed(BuildContext context) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen(camera: firstCamera)));
  }

  void onSectionPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MapButton()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // 왼쪽으로 20 이상 드래그하면 이동
        if (details.delta.dx < -20) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => RunSectionPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
                return SlideTransition(position: animation.drive(tween), child: child);
              },
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFD0F252),
        body: SafeArea(
          child: Stack(
            children: [
              // 중앙 콘텐츠
              const DistanceDisplay(),

              // 일시정지 버튼
              Positioned(
                bottom: 230,
                left: 0,
                right: 0,
                child: Center(
                  child: PauseButton(onTap: () => onPausePressed(context)),
                ),
              ),

              // 하단 버튼 (카메라 + 구간)
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: BottomButtons(
                  onCameraTap: () => onCameraPressed(context),
                  onMapTap: () => onSectionPressed(context),
                ),
              ),

              // 상단: 페이스
              const TopInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

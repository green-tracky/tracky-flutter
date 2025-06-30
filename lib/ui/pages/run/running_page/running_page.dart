import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/camera_screen.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/full_map_page.dart';
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => FullMapPage()));
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
              Align(
                alignment: Alignment(0, -0.3), // -1.0 = top, 0 = center, 1.0 = bottom
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '0.00',
                      style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    Text('킬로미터', style: TextStyle(fontSize: 25, color: Color(0xFF021F59))),
                  ],
                ),
              ),

              // 일시정지 버튼
              Positioned(
                bottom: 230,
                left: 0,
                right: 0,
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        onPausePressed(context);
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        child: Icon(Icons.pause, color: Colors.white, size: 36),
                      ),
                    ),
                  ),
                ),
              ),

              // 하단 버튼 2개 (카메라 + 구간)
              Positioned(
                bottom: 100,
                left: 100,
                child: ElevatedButton(
                  onPressed: () {
                    onCameraPressed(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 28),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 100,
                child: ElevatedButton(
                  onPressed: () {
                    onSectionPressed(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                  child: Icon(Icons.map, color: Colors.white, size: 28),
                ),
              ),

              // 상단: 페이스
              Positioned(
                top: 30,
                left: 30,
                child: Column(
                  children: [
                    Text(
                      "_'__\"",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text('페이스', style: TextStyle(fontSize: 16, color: Color(0xFF021F59))),
                  ],
                ),
              ),

              // 상단: 시간
              Positioned(
                top: 30,
                right: 30,
                child: Column(
                  children: [
                    Text(
                      '00:08',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text('시간', style: TextStyle(fontSize: 16, color: Color(0xFF021F59))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

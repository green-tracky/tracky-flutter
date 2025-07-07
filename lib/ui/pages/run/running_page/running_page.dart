import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_camera_button.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_distance.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_map_button.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_pause_button.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/widgets/running_top_info.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page.dart';
class RunRunningPage extends StatelessWidget {
  const RunRunningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < -20) {
          _navigateToSectionPage(context);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFD0F252),
        body: SafeArea(
          child: Stack(
            children: [
              TopInfo(pace: "_'__\"", time: "00:08"),
              RunningDistanceDisplay(distance: '0.00'),
              PauseRunButton(),
              CameraActionButton(),
              SectionActionButton(),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToSectionPage(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => RunSectionPage(),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.ease));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ),
  );
}

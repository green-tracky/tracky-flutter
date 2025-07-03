import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/button/pause_controller.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_map.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_stat.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class RunPausedPage extends ConsumerStatefulWidget {
  const RunPausedPage({super.key});

  @override
  ConsumerState<RunPausedPage> createState() => _RunPausedPageState();
}

class _RunPausedPageState extends ConsumerState<RunPausedPage> {
  @override
  void initState() {
    super.initState();
    ref.read(runPositionStreamProvider); // 위치 스트림 시작
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final currentPosition = ref.watch(currentPositionProvider);
    final markers = ref.watch(markerProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.5,
              child: PausedMap(
                currentPosition: currentPosition,
                markers: markers,
                onMapCreated: (controller) {
                  controller.animateCamera(CameraUpdate.newLatLng(currentPosition!));
                },
              ),
            ),
            SizedBox(height: 40),
            PausedStatDisplay(
              distance: "0.00",
              time: "00:47",
              calorie: "120",
              pace: "._._",
            ),
            SizedBox(height: 50),
            PausedControlButtons(),
          ],
        ),
      ),
    );
  }
}

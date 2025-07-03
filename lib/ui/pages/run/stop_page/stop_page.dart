import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/bottom_sheet/main_distance.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/bottom_sheet/main_speed.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/bottom_sheet/main_time.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/button/main_bottom.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/button/main_start.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_appbar.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_title.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/map/main_map.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/utils/location_utils.dart';

class RunMainPage extends ConsumerStatefulWidget {
  const RunMainPage({super.key});

  @override
  ConsumerState<RunMainPage> createState() => _RunMainPageState();
}

class _RunMainPageState extends ConsumerState<RunMainPage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _mapInitialized = false;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // 위치 요청 함수
  Future<void> _determinePosition() async {
    final latLng = await getCurrentLatLng();
    if (latLng == null) return;

    setState(() {
      _currentPosition = latLng;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('me'),
          position: latLng,
          infoWindow: InfoWindow(title: "내 위치"),
        ),
      );
    });

    // 지도 로드된 후라면 카메라 이동
    if (_mapInitialized && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  @override
  Widget build(BuildContext context) {
    final goalType = ref.watch(runGoalTypeProvider);
    final goalValue = ref.watch(runGoalValueProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppbar(),
      backgroundColor: Color(0xFFF9FAEB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 110),
          buildTitle(),
          SizedBox(height: 20),

          // 지도
          Expanded(
            child: Stack(
              children: [
                buildRunMap(
                  currentPosition: _currentPosition,
                  markers: _markers,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _mapInitialized = true;
                    if (_currentPosition != null) {
                      controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
                    }
                  },
                ),

                // 시간 (바텀시트)
                if (goalType == RunGoalType.time && goalValue != null) buildTimeGoal(context, goalValue.toInt()),

                // 거리 (바텀시트)
                if (goalType == RunGoalType.distance && goalValue != null) buildDistanceGoal(context, ref, goalValue),

                // 스피드 (바텀시트)
                if (goalType == RunGoalType.speed) buildSpeedGoal(context),

                // 시작 버튼
                buildstartbutton(context),

                // 하단 버튼
                buildbottombutton(context, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

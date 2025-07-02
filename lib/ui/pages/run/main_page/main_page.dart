import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/goal_type_bottom_sheet.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_appbar.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/time_setting_page.dart';
import 'package:tracky_flutter/utils/my_utils.dart';

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

  Future<void> _determinePosition() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final latLng = LatLng(position.latitude, position.longitude);

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
      appBar: MainAppbar(),
      backgroundColor: Color(0xFFF9FAEB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 110),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '러닝',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFF021F59)),
            ),
          ),
          SizedBox(height: 20),

          Expanded(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                      _mapInitialized = true;

                      if (_currentPosition != null) {
                        controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition ?? const LatLng(37.5665, 126.9780),
                      zoom: 16,
                    ),
                    markers: _markers,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationEnabled: true,
                  ),
                ),

                // 시간
                if (goalType == RunGoalType.time && goalValue != null)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => TimeSettingPage(initialValue: 0)),
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              formatTimeFromSeconds(goalValue.toInt()),
                              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Container(
                              width: 160,
                              height: 2,
                              color: Colors.black,
                            ),
                            SizedBox(height: 4),
                            Text("시간 : 분", style: TextStyle(fontSize: 25, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),

                // 거리
                if (goalType == RunGoalType.distance && goalValue != null)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          final result = await Navigator.push<double>(
                            context,
                            MaterialPageRoute(builder: (_) => DistanceSettingPage(initialDistance: goalValue)),
                          );
                          if (result != null) {
                            ref.read(runGoalValueProvider.notifier).state = result;
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              goalValue.toStringAsFixed(2),
                              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            Container(
                              width: 160,
                              height: 2,
                              color: Colors.black,
                            ),
                            SizedBox(height: 5),
                            Text("킬로미터", style: TextStyle(fontSize: 25, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),

                // 스피드
                if (ref.watch(runGoalTypeProvider) == RunGoalType.speed)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.10, // 화면 상단 25% 위치
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '러닝 중 랩을\n기록하세요',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                // 시작 버튼
                Positioned(
                  bottom: 150,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RunRunningPage()));
                      },
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(color: Color(0xFFD0F252), shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '시작',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 하단 버튼
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          showGoalSettingBottomSheet(context, ref);
                        },
                        icon: Icon(Icons.flag, color: Colors.black, size: 25),
                        label: Text("목표설정", style: TextStyle(color: Colors.black, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          minimumSize: Size(120, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

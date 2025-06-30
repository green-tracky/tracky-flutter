import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';
import 'package:tracky_flutter/ui/pages/run/stop_page/stop_page.dart';

class RunPausedPage extends ConsumerStatefulWidget {
  const RunPausedPage({super.key});

  @override
  ConsumerState<RunPausedPage> createState() => _RunPausedPageState();
}

class _RunPausedPageState extends ConsumerState<RunPausedPage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};

  Timer? _longPressTimer;
  bool _isLongPressTriggered = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final latLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = latLng;
      _markers.add(
        Marker(
          markerId: MarkerId("me"),
          position: latLng,
          infoWindow: InfoWindow(title: "내 위치"),
        ),
      );
    });

    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          children: [
            // 지도 영역
            Container(
              height: screenHeight * 0.5,
              child: _currentPosition == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onMapCreated: (controller) {
                        _mapController = controller;
                        controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
                      },
                      initialCameraPosition: CameraPosition(target: _currentPosition!, zoom: 18),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                      markers: _markers,
                    ),
            ),

            SizedBox(height: 40),

            // 지표 정보
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMetricColumn("0.00", "킬로미터"),
                  _buildMetricColumn("00:47", "시간"),
                  _buildMetricColumn("120", "칼로리"),
                ],
              ),
            ),

            SizedBox(height: 16),

            // 평균 페이스
            Center(
              child: Column(
                children: [
                  Text(
                    "._._",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text("평균 페이스", style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),

            SizedBox(height: 50),

            // 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 정지 버튼
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')));
                  },
                  onLongPressStart: (_) {
                    _isLongPressTriggered = false;
                    _longPressTimer = Timer(Duration(seconds: 3), () {
                      _isLongPressTriggered = true;

                      ref.read(runGoalTypeProvider.notifier).state = null;
                      ref.read(runGoalValueProvider.notifier).state = null;

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => RunStopPage()),
                        (route) => false,
                      );
                    });
                  },
                  onLongPressEnd: (_) {
                    _longPressTimer?.cancel();
                    if (!_isLongPressTriggered) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')));
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                    width: 64,
                    height: 64,
                    child: Icon(Icons.stop, color: Colors.white, size: 32),
                  ),
                ),
                SizedBox(width: 100),
                // 재시작 버튼
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RunRunningPage()));
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(color: Color(0xFFD0F252), shape: BoxShape.circle),
                    child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }
}

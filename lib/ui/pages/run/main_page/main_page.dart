import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_appbar.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_goal_setting_button.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_goal_value_display.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_map_preview.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_start_button.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/main_title.dart';

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

    if (_mapInitialized && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MainAppbar(),
      backgroundColor: Color(0xFFF9FAEB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 110),
          RunMainTitle(),
          SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                MainMapPreview(
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
                GoalValueDisplay(),
                StartRunButton(),
                GoalSettingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

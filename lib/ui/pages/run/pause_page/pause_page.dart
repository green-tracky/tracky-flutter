import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_average_pace_row.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_map_preview.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_metric_row.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_resume_button.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_stop_button.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class RunPausedPage extends ConsumerStatefulWidget {
  const RunPausedPage({super.key});

  @override
  ConsumerState<RunPausedPage> createState() => _RunPausedPageState();
}

class _RunPausedPageState extends ConsumerState<RunPausedPage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  StreamSubscription<Position>? _positionSub;
  Position? _lastPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startListeningPosition();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final latLng = LatLng(position.latitude, position.longitude);
    setState(() {
      _currentPosition = latLng;
      _markers.add(Marker(markerId: MarkerId("me"), position: latLng));
    });
    _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  void _startListeningPosition() {
    _positionSub = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    ).listen((position) {
      if (_lastPosition != null) {
        final distanceInMeters = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
        final previous = ref.read(runDistanceProvider);
        ref.read(runDistanceProvider.notifier).state = previous + (distanceInMeters / 1000);
      }
      _lastPosition = position;
    });
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          children: [
            if (_currentPosition == null)
              Expanded(child: Center(child: CircularProgressIndicator()))
            else
              PausedMapPreview(
                currentPosition: _currentPosition!,
                markers: _markers,
                onMapCreated: (controller) => _mapController = controller,
              ),
            SizedBox(height: 40),
            PausedMetricRow(),
            SizedBox(height: 16),
            AveragePaceDisplay(),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StopRunButton(onFinish: () {}),
                SizedBox(width: 100),
                ResumeRunButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

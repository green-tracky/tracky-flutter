import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunPausedMap extends ConsumerStatefulWidget {
  const RunPausedMap({super.key});

  @override
  ConsumerState<RunPausedMap> createState() => _RunPausedMapState();
}

class _RunPausedMapState extends ConsumerState<RunPausedMap> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(pos.latitude, pos.longitude);
      });
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    } catch (e) {
      debugPrint('위치 가져오기 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (_currentPosition == null) {
      return SizedBox(
        height: screenHeight * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: screenHeight * 0.5,
      width: double.infinity,
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
        },
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 16,
        ),
        markers: {
          Marker(markerId: const MarkerId('me'), position: _currentPosition!),
        },
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
  }
}

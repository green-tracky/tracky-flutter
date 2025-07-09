// run_map.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunMapSection extends StatefulWidget {
  const RunMapSection({super.key});

  @override
  State<RunMapSection> createState() => _RunMapSectionState();
}

class _RunMapSectionState extends State<RunMapSection> {
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
          markerId: const MarkerId('me'),
          position: latLng,
          infoWindow: const InfoWindow(title: "내 위치"),
        ),
      );
    });

    if (_mapInitialized && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
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
        myLocationButtonEnabled: false,
      ),
    );
  }
}

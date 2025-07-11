import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RunPausedMap extends StatefulWidget {
  const RunPausedMap({super.key});

  @override
  State<RunPausedMap> createState() => _RunPausedMapState();
}

class _RunPausedMapState extends State<RunPausedMap> {
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
          infoWindow: InfoWindow(title: '내 위치'),
        ),
      );
    });

    if (_mapInitialized && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (_currentPosition == null) {
      return Container(
        height: height * 0.5,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      height: height * 0.5,
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _mapInitialized = true;
          if (_currentPosition != null) {
            controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
          }
        },
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 15,
        ),
        markers: _markers,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        myLocationButtonEnabled: false,
      ),
    );
  }
}

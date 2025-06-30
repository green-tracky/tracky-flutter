import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapPage extends StatefulWidget {
  const FullMapPage({super.key});

  @override
  State<FullMapPage> createState() => _FullMapPageState();
}

class _FullMapPageState extends State<FullMapPage> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // 현재 위치 가져오기 및 카메라 이동
  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final latLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentLatLng = latLng;
      });

      _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
    } catch (e) {
      debugPrint("위치 가져오기 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 구글 지도
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng ?? LatLng(37.5665, 126.9780), // fallback: 서울
              zoom: 18,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              if (_currentLatLng != null) {
                _mapController!.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),

          // 닫기 버튼
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.black,
              child: Icon(Icons.close, color: Colors.white),
            ),
          ),

          // 내 위치 이동 버튼
          Positioned(
            bottom: 30,
            left: 30,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: Colors.white,
              child: Icon(Icons.my_location, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

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
  late final Stream<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _initLocationStream();
  }

  void _initLocationStream() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    );

    _positionStream.listen((position) {
      final latLng = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentLatLng = latLng;
      });
      _mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 현재 위치 정보 없을 때는 로딩 중
          if (_currentLatLng == null)
            const Center(child: CircularProgressIndicator())
          else
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLatLng!,
                zoom: 18,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                _mapController!.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),

          // 닫기 버튼
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              heroTag: 'close_map',
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.black,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),

          // 내 위치 이동 버튼
          if (_currentLatLng != null)
            Positioned(
              bottom: 30,
              left: 30,
              child: FloatingActionButton(
                heroTag: 'goto_my_location',
                onPressed: () {
                  _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.my_location, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}

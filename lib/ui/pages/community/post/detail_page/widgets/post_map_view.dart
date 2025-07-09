import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostMapView extends StatefulWidget {
  final List<LatLng> path;

  const PostMapView({super.key, required this.path});

  @override
  State<PostMapView> createState() => _PostMapViewState();
}

class _PostMapViewState extends State<PostMapView> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  int _markerIdCounter = 0;

  @override
  void initState() {
    super.initState();
    _setupMarkers();
  }

  void _setupMarkers() {
    _addPhotoMarker(LatLng(35.158402, 129.059361), 'assets/images/kb_bank.png');
    _addPhotoMarker(
      LatLng(35.159250, 129.060054),
      'assets/images/kyochon_chicken.png',
    );
  }

  void _addPhotoMarker(LatLng position, String imagePath) {
    final markerId = MarkerId('marker_${_markerIdCounter++}');

    final marker = Marker(
      markerId: markerId,
      position: position,
      onTap: () => _showPhotoDialog(imagePath),
    );

    _markers.add(marker);
  }

  void _showPhotoDialog(String imagePath) {
    showDialog(
      context: context,
      barrierColor: const Color(0xE6000000), // 사진 배경 반투명하게 보이게 하는 색
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain, // 원본 비율 유지
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  LatLngBounds _getBounds(List<LatLng> points) {
    final swLat = points.map((e) => e.latitude).reduce((a, b) => a < b ? a : b);
    final swLng = points
        .map((e) => e.longitude)
        .reduce((a, b) => a < b ? a : b);
    final neLat = points.map((e) => e.latitude).reduce((a, b) => a > b ? a : b);
    final neLng = points
        .map((e) => e.longitude)
        .reduce((a, b) => a > b ? a : b);
    return LatLngBounds(
      southwest: LatLng(swLat, swLng),
      northeast: LatLng(neLat, neLng),
    );
  }

  Set<Polyline> _buildPolyline() {
    return {
      Polyline(
        polylineId: const PolylineId("post_path"),
        color: Colors.blue,
        width: 5,
        points: widget.path,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          onMapCreated: (controller) {
            _controller = controller;
            Future.delayed(const Duration(milliseconds: 300), () {
              _controller.animateCamera(
                CameraUpdate.newLatLngBounds(_getBounds(widget.path), 50),
              );
            });
          },
          markers: _markers,
          polylines: _buildPolyline(),
          zoomControlsEnabled: true, // 확대 축소 버튼 활성화
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => ScaleGestureRecognizer(), // 두 손가락 확대/축소 허용
            ),
          },
          initialCameraPosition: CameraPosition(
            target: widget.path.first,
            zoom: 16,
          ),
        ),
      ),
    );
  }
}

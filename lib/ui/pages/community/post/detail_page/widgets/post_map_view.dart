import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class PostMapView extends StatefulWidget {
  final List<List<LatLng>> paths;

  const PostMapView({super.key, required this.paths});

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
    // 기존 마커
    _addPhotoMarker(LatLng(35.158402, 129.059361), 'assets/images/kb_bank.png');
    _addPhotoMarker(
      LatLng(35.159250, 129.060054),
      'assets/images/kyochon_chicken.png',
    );

    // 새로운 경로 마커
    _addPhotoMarker(
      LatLng(35.161344, 129.063424),
      'assets/images/Screenshot_1.png',
    );
    _addPhotoMarker(
      LatLng(35.157887, 129.064746),
      'assets/images/Screenshot_2.png',
    );

    setState(() {}); // 반드시 필요
  }

  void _addPhotoMarker(LatLng position, String imagePath) {
    final markerId = MarkerId('marker_${_markerIdCounter++}');

    final marker = Marker(
      markerId: markerId,
      position: position,
      onTap: () {
        _showPhotoDialog(imagePath);
      },
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
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: Gap.xxlGap,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  LatLngBounds _getBounds() {
    final allPoints = widget.paths.expand((path) => path).toList()
      ..addAll(_markers.map((m) => m.position));

    final swLat = allPoints
        .map((e) => e.latitude)
        .reduce((a, b) => a < b ? a : b);
    final swLng = allPoints
        .map((e) => e.longitude)
        .reduce((a, b) => a < b ? a : b);
    final neLat = allPoints
        .map((e) => e.latitude)
        .reduce((a, b) => a > b ? a : b);
    final neLng = allPoints
        .map((e) => e.longitude)
        .reduce((a, b) => a > b ? a : b);

    return LatLngBounds(
      southwest: LatLng(swLat, swLng),
      northeast: LatLng(neLat, neLng),
    );
  }

  Set<Polyline> _buildPolylines() {
    final Set<Polyline> polylines = {};
    for (int i = 0; i < widget.paths.length; i++) {
      polylines.add(
        Polyline(
          polylineId: PolylineId("path_$i"),
          color: Colors.blue,
          width: 5,
          points: widget.paths[i],
        ),
      );
    }
    return polylines;
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
                CameraUpdate.newLatLngBounds(_getBounds(), 50),
              );
            });
          },
          markers: _markers,
          polylines: _buildPolylines(),
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
            target: widget.paths.first.first,
            zoom: 16,
          ),
        ),
      ),
    );
  }
}

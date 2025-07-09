// 📄 map_view_page.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final List<List<LatLng>> paths;

  const MapView({required this.paths, super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _moveToFitBounds());
  }

  Future<void> _moveToFitBounds() async {
    final controller = await _controller.future;
    final allPoints = widget.paths.expand((p) => p).toList();

    if (allPoints.isEmpty) return;

    double minLat = allPoints.first.latitude;
    double maxLat = allPoints.first.latitude;
    double minLng = allPoints.first.longitude;
    double maxLng = allPoints.first.longitude;

    for (var point in allPoints) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }

  @override
  Widget build(BuildContext context) {
    final allPoints = widget.paths.expand((p) => p).toList();

    final Set<Marker> markers = {};
    for (int i = 0; i < widget.paths.length; i++) {
      final path = widget.paths[i];
      if (path.length >= 2) {
        markers.add(
          Marker(
            markerId: MarkerId("start_$i"),
            position: path.first,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
        markers.add(
          Marker(
            markerId: MarkerId("end_$i"),
            position: path.last,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GoogleMap(
        onMapCreated: (controller) => _controller.complete(controller),
        initialCameraPosition: CameraPosition(
          target: allPoints.isNotEmpty ? allPoints.first : LatLng(37.5665, 126.9780),
          zoom: 16,
        ),
        polylines: {
          for (int i = 0; i < widget.paths.length; i++)
            Polyline(
              polylineId: PolylineId("path_$i"),
              points: widget.paths[i],
              color: Colors.green,
              width: 6,
            ),
        },
        markers: markers,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
        mapType: MapType.normal,
      ),
    );
  }
}

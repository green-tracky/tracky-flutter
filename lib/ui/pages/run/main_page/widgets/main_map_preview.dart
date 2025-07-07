import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainMapPreview extends StatelessWidget {
  final LatLng? currentPosition;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;

  const MainMapPreview({
    super.key,
    required this.currentPosition,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPosition ?? const LatLng(37.5665, 126.9780),
          zoom: 16,
        ),
        markers: markers,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
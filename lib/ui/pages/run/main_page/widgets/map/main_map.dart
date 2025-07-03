import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget buildRunMap({
  required LatLng? currentPosition,
  required Set<Marker> markers,
  required Function(GoogleMapController) onMapCreated,
}) {
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

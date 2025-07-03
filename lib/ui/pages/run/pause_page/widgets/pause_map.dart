// pause_page/widgets/paused_map.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PausedMap extends StatelessWidget {
  final LatLng? currentPosition;
  final Set<Marker> markers;
  final void Function(GoogleMapController controller) onMapCreated;

  PausedMap({
    required this.currentPosition,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    if (currentPosition == null) {
      return Center(child: CircularProgressIndicator());
    }

    return GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(target: currentPosition!, zoom: 15),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      markers: markers,
    );
  }
}

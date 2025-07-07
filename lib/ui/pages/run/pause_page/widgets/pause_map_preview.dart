import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PausedMapPreview extends StatelessWidget {
  final LatLng currentPosition;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;

  const PausedMapPreview({
    super.key,
    required this.currentPosition,
    required this.markers,
    required this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.5,
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPosition,
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        markers: markers,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page_vm.dart';

class RunMainMapSection extends ConsumerStatefulWidget {
  const RunMainMapSection({super.key});

  @override
  ConsumerState<RunMainMapSection> createState() => _RunMainMapSectionState();
}

class _RunMainMapSectionState extends ConsumerState<RunMainMapSection> {
  GoogleMapController? _mapController;
  bool _mapInitialized = false;

  @override
  Widget build(BuildContext context) {
    final currentLocation = ref.watch(runMainProvider).currentLocation;

    final cameraPosition = CameraPosition(
      target: currentLocation ?? const LatLng(37.5665, 126.9780),
      zoom: 16,
    );

    final markers = <Marker>{};
    if (currentLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('me'),
          position: currentLocation,
          infoWindow: const InfoWindow(title: '내 위치'),
        ),
      );
    }

    return Opacity(
      opacity: 0.4,
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _mapInitialized = true;
          if (currentLocation != null) {
            controller.animateCamera(CameraUpdate.newLatLng(currentLocation));
          }
        },
        initialCameraPosition: cameraPosition,
        markers: markers,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }
}

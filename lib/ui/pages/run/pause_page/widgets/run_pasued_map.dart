import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_page_vm.dart';

class RunPausedMap extends ConsumerStatefulWidget {
  const RunPausedMap({super.key});

  @override
  ConsumerState<RunPausedMap> createState() => _RunPausedMapState();
}

class _RunPausedMapState extends ConsumerState<RunPausedMap> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    // 지도 준비 시 VM에서 위치를 가져옵니다.
    ref.read(runPausedProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runPausedProvider);
    final position = state.currentPosition;
    final screenHeight = MediaQuery.of(context).size.height;

    // 위치 정보 준비 전에는 로딩 표시
    if (position == null) {
      return SizedBox(
        height: screenHeight * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 위치 정보가 있으면 지도 표시
    return SizedBox(
      height: screenHeight * 0.5,
      width: double.infinity,
      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          // 카메라를 현재 위치로 이동
          controller.animateCamera(
            CameraUpdate.newLatLng(position),
          );
        },
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 16,
        ),
        markers: {
          Marker(markerId: const MarkerId('me'), position: position),
        },
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
  }
}

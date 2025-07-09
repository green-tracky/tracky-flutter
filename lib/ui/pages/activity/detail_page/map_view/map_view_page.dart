// 📄 map_view_page.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 여러 개의 경로(List<LatLng>)를 지도에 그려주는 위젯
/// - 각 경로마다 Polyline(녹색 선)으로 표시
/// - 시작점(초록 마커), 끝점(빨간 마커) 표시
/// - 전체 경로가 지도의 범위에 자동으로 맞춰짐
class MapView extends StatefulWidget {
  final List<List<LatLng>> paths; // 여러 개의 경로 리스트

  const MapView({required this.paths, super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // 지도 컨트롤러를 비동기로 저장할 Completer
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    // 프레임이 그려진 후 모든 경로가 화면에 들어오도록 카메라 이동
    WidgetsBinding.instance.addPostFrameCallback((_) => _moveToFitBounds());
  }

  /// 전체 경로들을 기준으로 LatLngBounds 계산 → 카메라 자동 이동
  Future<void> _moveToFitBounds() async {
    final controller = await _controller.future;
    final allPoints = widget.paths.expand((p) => p).toList(); // 모든 LatLng를 평평하게 펼침

    if (allPoints.isEmpty) return;

    // 최소/최대 위도경도 계산
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

    // 경로들을 감싸는 bounds 생성
    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    // 카메라 이동
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  }

  @override
  Widget build(BuildContext context) {
    final allPoints = widget.paths.expand((p) => p).toList(); // 전체 좌표 리스트

    // 시작/끝 마커 세팅
    final Set<Marker> markers = {};
    for (int i = 0; i < widget.paths.length; i++) {
      final path = widget.paths[i];
      if (path.length >= 2) {
        markers.add(
          Marker(
            markerId: MarkerId("start_$i"),
            position: path.first,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // 시작점(초록색)
          ),
        );
        markers.add(
          Marker(
            markerId: MarkerId("end_$i"),
            position: path.last,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // 끝점(빨간색)
          ),
        );
      }
    }

    // 실제 지도 UI
    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // 지도 둥근 모서리
      child: GoogleMap(
        onMapCreated: (controller) => _controller.complete(controller), // 지도 컨트롤러 저장
        initialCameraPosition: CameraPosition(
          target: allPoints.isNotEmpty ? allPoints.first : LatLng(37.5665, 126.9780), // 기본 위치
          zoom: 16,
        ),
        // 경로 그리기
        polylines: {
          for (int i = 0; i < widget.paths.length; i++)
            Polyline(
              polylineId: PolylineId("path_$i"),
              points: widget.paths[i],
              color: Colors.green, // 선 색상
              width: 6, // 선 두께
            ),
        },
        // 마커 추가
        markers: markers,

        // 상호작용 옵션
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
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

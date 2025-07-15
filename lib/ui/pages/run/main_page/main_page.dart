import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart'; // 위치 패키지 추가!
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page_vm.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_goal_setting_button.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_goal_value_view.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_main_appbar.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_main_title.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_map_section.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/widgets/run_start_button.dart';

class RunMainPage extends ConsumerStatefulWidget {
  const RunMainPage({super.key});

  @override
  ConsumerState<RunMainPage> createState() => _RunMainPageState();
}

class _RunMainPageState extends ConsumerState<RunMainPage> {
  StreamSubscription<Position>? _locationSub;

  @override
  void initState() {
    super.initState();
    _requestPermissionAndListen();
  }

  Future<void> _requestPermissionAndListen() async {
    // 권한 요청
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return; // 권한 거부 시 위치 구독 안함
      }
    }

    // 위치 스트림 구독
    _locationSub =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 3, // 최소 이동 거리(m)마다 업데이트 (선택)
          ),
        ).listen((Position pos) {
          ref
              .read(runMainProvider.notifier)
              .updateLocation(
                LatLng(pos.latitude, pos.longitude),
              );
        });
  }

  @override
  void dispose() {
    _locationSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const RunMainAppBar(),
      backgroundColor: AppColors.trackyBGreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap.ss,
          const RunMainTitle(),
          Gap.l,
          Expanded(
            child: Stack(
              children: [
                const RunMainMapSection(),
                const RunGoalValueView(),
                const RunGoalSettingButton(),
                const RunStartButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

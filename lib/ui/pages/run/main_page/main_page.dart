import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
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
  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final latLng = LatLng(position.latitude, position.longitude);
    ref.read(runMainProvider.notifier).updateLocation(latLng);
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

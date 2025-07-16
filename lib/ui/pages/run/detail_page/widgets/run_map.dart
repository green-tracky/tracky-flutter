// 📄 widgets/run_map_section.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/map_view/map_view_page.dart';

class RunMapSection extends StatelessWidget {
  final List<List<LatLng>> paths;

  const RunMapSection({required this.paths, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: MapView(paths: paths),
      ),
    );
  }
}

class RunDetailMapSection extends StatelessWidget {
  final List<List<LatLng>> paths;
  const RunDetailMapSection({super.key, required this.paths});

  @override
  Widget build(BuildContext context) {
    return RunMapSection(paths: paths);
  }
}

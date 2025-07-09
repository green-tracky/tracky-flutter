import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/intensity/intensity_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/memo_page/memo_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/road_menu/place_sheet_page.dart';

class RunMetaTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback onTap;
  final bool showDivider; // Divider 유무
  final EdgeInsetsGeometry padding; // 간격 조절용

  const RunMetaTile({
    required this.title,
    required this.trailing,
    required this.onTap,
    this.showDivider = true,
    this.padding = const EdgeInsets.symmetric(vertical: 2), // 기본 간격
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: trailing,
            onTap: onTap,
          ),
        ),
        if (showDivider) Divider(thickness: 0.8),
      ],
    );
  }
}

class RunDetailMetaSection extends ConsumerWidget {
  final int? intensity;
  final RunningSurface? place;
  final String? memo;

  const RunDetailMetaSection({
    this.intensity,
    this.place,
    this.memo,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = ref.watch(runIntensityProvider);
    final place = ref.watch(runningSurfaceProvider);
    final memo = ref.watch(runMemoProvider);

    return Column(
      children: [
        RunMetaTile(
          title: "러닝 강도",
          trailing: intensity == null
              ? Icon(Icons.add)
              : Text("$intensity/10", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const IntensityPage()),
            );
          },
        ),
        RunMetaTile(
          title: "러닝 장소",
          trailing: place == null ? Icon(Icons.add) : Icon(getSurfaceIcon(place), color: AppColors.trackyIndigo),
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.trackyBGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => SurfaceSelectSheet(
                onSelect: (s) {
                  ref.read(runningSurfaceProvider.notifier).state = s;
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
        RunMetaTile(
          title: "메모",
          trailing: memo == null || memo!.isEmpty ? Icon(Icons.add) : Icon(Icons.edit, color: AppColors.trackyIndigo),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MemoPage())),
          showDivider: false,
        ),
      ],
    );
  }
}

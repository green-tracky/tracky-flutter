import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/intensity/intensity_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/memo_page/memo_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/road_menu/place_sheet_page.dart';

import '../../run_vm.dart';
import '../detail_page_vm.dart';

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
  int? intensity;
  RunningSurface? place;
  String? memo;

  RunDetailMetaSection({
    this.intensity,
    this.place,
    this.memo,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    intensity = ref.watch(runIntensityProvider);
    place = ref.watch(runningSurfaceProvider);
    memo = ref.watch(runMemoProvider);
    final runId = ref.watch(runDetailProvider)?.id;

    return Column(
      children: [
        RunMetaTile(
          title: "러닝 강도",
          trailing: intensity == null
              ? const Icon(Icons.add)
              : Text("$intensity/10", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          onTap: () async {
            final selected = await Navigator.push<int>(
              context,
              MaterialPageRoute(builder: (_) => const IntensityPage()),
            );

            if (selected != null) {
              ref.read(runIntensityProvider.notifier).state = selected;

              final runId = ref.read(runDetailProvider)?.id;
              if (runId != null) {
                final vm = ref.read(runDetailProvider.notifier);
                await vm.updateFields(runId, intensity: selected);
              }
            }
          },
        ),
        RunMetaTile(
          title: "러닝 장소",
          trailing: place == null ? const Icon(Icons.add) : Icon(getSurfaceIcon(place!), color: AppColors.trackyIndigo),
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.trackyBGreen,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => SurfaceSelectSheet(
                onSelect: (s) async {
                  ref.read(runningSurfaceProvider.notifier).state = s;
                  Navigator.pop(context);

                  if (runId != null) {
                    final vm = ref.read(runDetailProvider.notifier);
                    await vm.updateFields(runId, place: s.serverValue);
                  }
                },
              ),
            );
          },
        ),
        RunMetaTile(
          title: "메모",
          trailing: memo == null ? const Icon(Icons.add) : const Icon(Icons.edit, color: AppColors.trackyIndigo),
          onTap: () async {
            final result = await Navigator.push<String>(
              context,
              MaterialPageRoute(builder: (_) => MemoPage(initialMemo: memo,)),
            );

            if (result != null) {
              ref.read(runMemoProvider.notifier).state = result;
              final runId = ref.read(runDetailProvider)?.id;

              if (runId != null) {
                final vm = ref.read(runDetailProvider.notifier);
                await vm.updateFields(runId, memo: result);
              }
            }
          },
          showDivider: false,
        ),
      ],
    );
  }
}

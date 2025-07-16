import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/detail_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/intensity/intensity_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/memo_page/memo_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/road_menu/place_sheet_page.dart';

class ActivityMetaTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback onTap;
  final bool showDivider; // Divider 유무
  final EdgeInsetsGeometry padding; // 간격 조절용

  const ActivityMetaTile({
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

class ActivityDetailMetaSection extends ConsumerWidget {
  final int runId;

  const ActivityDetailMetaSection({super.key, required this.runId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncModel = ref.watch(activityDetailProvider(runId));

    return asyncModel.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('에러 발생: $e')),
      data: (data) {
        if (data == null) return const SizedBox();

        int intensity = data.intensity!;
        RunningSurface place = data.place!;
        String memo = data.memo!;

        return Column(
          children: [
            ActivityMetaTile(
              title: "러닝 강도",
              trailing: intensity == null
                  ? const Icon(Icons.add)
                  : Text(
                      "$intensity/10",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              onTap: () async {
                final selected = await Navigator.push<int>(
                  context,
                  MaterialPageRoute(builder: (_) => const IntensityPage()),
                );

                if (selected != null) {
                  final vm = ref.read(activityDetailProvider(runId).notifier);
                  await vm.updateFields(runId, intensity: selected);
                  ref.invalidate(activityDetailProvider(runId));
                  print("통신 완료");
                }
              },
            ),
            ActivityMetaTile(
              title: "러닝 장소",
              trailing: place == null
                  ? const Icon(Icons.add)
                  : Icon(getSurfaceIcon(place), color: AppColors.trackyIndigo),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColors.trackyBGreen,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (_) => SurfaceSelectSheet(
                    onSelect: (s) async {
                      print("장소 선택 : ${s.serverValue}");
                      try {
                        final vm = ref.read(
                          activityDetailProvider(runId).notifier,
                        );
                        await vm.updateFields(runId, place: s.serverValue);
                        ref.invalidate(activityDetailProvider(runId));
                        print("✅ 통신 완료");
                        Navigator.pop(context);
                      } catch (e, st) {
                        print("❌ 통신 중 에러 발생: $e");
                        print(st);
                      }
                    },
                  ),
                );
              },
            ),
            ActivityMetaTile(
              title: "메모",
              trailing: memo == null
                  ? const Icon(Icons.add)
                  : const Icon(Icons.edit, color: AppColors.trackyIndigo),
              onTap: () async {
                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MemoPage(initialMemo: memo),
                  ),
                );

                if (result != null) {
                  final vm = ref.read(activityDetailProvider(runId).notifier);
                  await vm.updateFields(runId, memo: result);
                  ref.invalidate(activityDetailProvider(runId));
                  print("통신 완료");
                }
              },
              showDivider: false,
            ),
          ],
        );
      },
    );
  }
}

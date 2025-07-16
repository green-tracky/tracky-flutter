import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/detail_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/widgets/activity_meta_tile.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/widgets/editable_title.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/runsegment_detail_page/segment_detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_map.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_section_summary.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_summary.dart';

class ActivityDetailPage extends ConsumerWidget {
  final int runId;

  const ActivityDetailPage({super.key, required this.runId});

  String _getFormattedDate(DateTime time) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncModel = ref.watch(activityDetailProvider(runId));

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: asyncModel.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러 발생: $e')),
        data: (data) {
          if (data == null) return const Center(child: Text('데이터가 없습니다'));

          final segment = data.segments.first;
          final paths = data.paths;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getFormattedDate(segment.startDate),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Gap.ss,
                Row(
                  children: [
                    Expanded(
                      child: EditableTitle(
                        initialTitle: data.title ?? '러닝 기록',
                        onSubmit: (newTitle) async {
                          print("제목 수정 : $newTitle");
                          await ref.read(activityDetailProvider(runId).notifier).updateFields(runId, title: newTitle);
                          ref.invalidate(
                            activityDetailProvider(runId),
                          ); // 수정 후 리로딩
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                Gap.ss,
                RunDetailStatsSection(result: data),
                Gap.xl,
                RunDetailMapSection(paths: paths),
                Gap.l,
                RunSectionSummary(
                  result: data,
                  isLoading: false,
                  onFetchFromServer: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RunSegmentDetailPage(
                          segment: segment,
                          calories: data.calories,
                        ),
                      ),
                    );
                  },
                ),
                Gap.l,
                ActivityDetailMetaSection(
                  runId: runId,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

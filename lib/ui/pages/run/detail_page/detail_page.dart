import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/detail_page_vm.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_appbar_button.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_map.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_mata_tile.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_section_summary.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_summary.dart';

class RunDetailPage extends ConsumerStatefulWidget {
  final int runId;
  const RunDetailPage({required this.runId, super.key});

  @override
  ConsumerState<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends ConsumerState<RunDetailPage> {
  bool isEditingTitle = false;
  late TextEditingController _titleController;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncResult = ref.watch(runDetailProvider(widget.runId));

    return asyncResult.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        body: Center(child: Text('에러 발생: $err')),
      ),
      data: (result) {
        final defaultTitle = _getDefaultTitle(result.segments.first.startDate);
        _titleController = TextEditingController(text: defaultTitle);

        return Scaffold(
          backgroundColor: AppColors.trackyBGreen,
          appBar: AppBar(
            backgroundColor: AppColors.trackyBGreen,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              buildIconButton(context),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getFormattedDate(result.segments.first.startDate),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Gap.ss,
                Row(
                  children: [
                    Expanded(
                      child: isEditingTitle
                          ? TextField(
                              controller: _titleController,
                              autofocus: true,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.trackyIndigo,
                              ),
                              onSubmitted: (_) => setState(() => isEditingTitle = false),
                            )
                          : GestureDetector(
                              onTap: () => setState(() => isEditingTitle = true),
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  _titleController.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.trackyIndigo,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    IconButton(
                      icon: Icon(
                        isEditingTitle ? Icons.check : Icons.edit,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => isEditingTitle = !isEditingTitle);
                      },
                    ),
                  ],
                ),
                Divider(color: Colors.grey[400]),
                Gap.ss,
                RunDetailStatsSection(result: result),
                Gap.xl,
                RunDetailMapSection(paths: result.paths),
                Gap.l,
                RunSectionSummary(result: result),
                Gap.l,
                RunDetailMetaSection(
                  intensity: result.intensity,
                  place: result.place,
                  memo: result.memo,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getDefaultTitle(DateTime time) {
    final weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    final hour = time.hour;
    final ampm = hour < 12 ? '오전' : '오후';
    final weekday = weekdays[time.weekday - 1];
    return "$weekday $ampm 러닝";
  }

  String _getFormattedDate(DateTime time) {
    return DateFormat('yyyy. MM. dd. - HH:mm').format(time);
  }
}

// lib/ui/pages/run/detail_page/run_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../_core/constants/theme.dart';
import 'detail_page_vm.dart';
import 'widgets/run_appbar_button.dart';
import 'widgets/run_map.dart';
import 'widgets/run_mata_tile.dart';
import 'widgets/run_section_summary.dart';
import 'widgets/run_summary.dart';

class RunDetailPage extends ConsumerStatefulWidget {
  final int runId;
  const RunDetailPage({required this.runId, Key? key}) : super(key: key);

  @override
  ConsumerState<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends ConsumerState<RunDetailPage> {
  bool isEditingTitle = false;
  bool _didSetDefaultTitle = false;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  /// 기본 제목: 오늘 날짜 기준 '요일 오전/오후 러닝'
  String _getDefaultTitle() {
    final now = DateTime.now();
    final weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    final ampm = now.hour < 12 ? '오전' : '오후';
    final weekday = weekdays[now.weekday - 1];
    return '$weekday $ampm 러닝';
  }

  String _getFormattedDate(DateTime time) {
    return DateFormat('yyyy. MM. dd. - HH:mm').format(time);
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
        if (!_didSetDefaultTitle) {
          _titleController.text = _getDefaultTitle();
          _didSetDefaultTitle = true;
        }

        return Scaffold(
          backgroundColor: AppColors.trackyBGreen,
          appBar: AppBar(
            backgroundColor: AppColors.trackyBGreen,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [buildIconButton(context)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getFormattedDate(result.segments.first.startDate),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Gap.ss,
                Row(
                  children: [
                    Expanded(
                      child: isEditingTitle
                          ? TextField(
                              controller: _titleController,
                              autofocus: true,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.trackyIndigo,
                              ),
                              onSubmitted: (_) async {
                                final newTitle = _titleController.text.trim();
                                await ref
                                    .read(runDetailProvider(widget.runId).notifier)
                                    .updateTitle(widget.runId, newTitle);
                                setState(() => isEditingTitle = false);
                              },
                              decoration: const InputDecoration(
                                isDense: true,
                                border: UnderlineInputBorder(),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => setState(() => isEditingTitle = true),
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  _titleController.text,
                                  style: const TextStyle(
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
                        color: AppColors.trackyIndigo,
                      ),
                      onPressed: () async {
                        if (isEditingTitle) {
                          final newTitle = _titleController.text.trim();
                          await ref.read(runDetailProvider(widget.runId).notifier).updateTitle(widget.runId, newTitle);
                        }
                        setState(() => isEditingTitle = !isEditingTitle);
                      },
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
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
}

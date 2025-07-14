import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/repository/RunRepository.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/detail_page_vm.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/runsegment_detail_page/segment_detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_appbar_button.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_map.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_mata_tile.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_section_summary.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_summary.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';

import '../../../../data/model/Run.dart';

class RunDetailPage extends ConsumerStatefulWidget {
  final RunResult initialLocalResult;

  const RunDetailPage({
    required this.initialLocalResult,
    super.key,
  });

  @override
  ConsumerState<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends ConsumerState<RunDetailPage> {
  bool isEditingTitle = false;
  bool _didSetDefaultTitle = false;
  bool _isLoadingServerData = false;
  late RunResult _currentResult;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _currentResult = widget.initialLocalResult;

    Future.microtask(() async {
      try {
        print('👉 저장할 데이터: ${_currentResult.toJson()}');
        final response = await ref.read(runRepositoryProvider).saveRunToServer(_currentResult);
        print('✅ 러닝 결과 서버 저장 완료: $response');

        // runDetailProvider에 ID 저장
        ref.read(runDetailProvider.notifier).setFromServerResponse(response);
      } catch (e) {
        print('❌ 서버 저장 실패: $e');
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String _getDefaultTitle() {
    final now = DateTime.now();
    final weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    final ampm = now.hour < 12 ? '오전' : '오후';
    final weekday = weekdays[now.weekday - 1];
    return '$weekday $ampm 러닝';
  }

  String _getFormattedDate(DateTime time) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
  }

  Future<void> _fetchServerData() async {
    setState(() => _isLoadingServerData = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("잠시만 기다려주세요...")),
    );

    try {
      final runId = ref.watch(runDetailProvider)?.id;
      if (runId == null) return;

      final result = await RunDetailRepository.instance.getOneRun(runId);

      setState(() {
        _currentResult = result;
        _isLoadingServerData = false;
      });

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RunSegmentDetailPage(
              segment: result.segments.first,
              calories: result.calories,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoadingServerData = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("데이터를 불러오지 못했습니다")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _currentResult;
    final runId = ref.watch(runDetailProvider)?.id;

    if (!_didSetDefaultTitle) {
      _titleController.text = result.title ?? _getDefaultTitle();
      _didSetDefaultTitle = true;
    }

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            ref.invalidate(runRunningProvider);
            Navigator.of(context).pushNamedAndRemoveUntil('/running', (route) => false);
          },
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
                            await ref.read(runDetailProvider.notifier).updateTitle(runId!, newTitle);
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
                      print('🟢 수정된 제목: $newTitle');
                      await ref.read(runDetailProvider.notifier).updateTitle(runId!, newTitle);
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
            RunSectionSummary(
              result: result,
              onFetchFromServer: _fetchServerData,
              isLoading: _isLoadingServerData,
            ),
            Gap.l,
            RunDetailMetaSection(),
          ],
        ),
      ),
    );
  }
}

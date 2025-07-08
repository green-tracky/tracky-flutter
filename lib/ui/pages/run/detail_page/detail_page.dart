// run_detail_page.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/intensity/intensity_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/memo_page/memo_page.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/road_menu/place_sheet_page.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_goal_row.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_info.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_map.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_mata_tile.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_summary.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';

class RunDetailPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<RunDetailPage> createState() => _RunDetailPageState();
}

class _RunDetailPageState extends ConsumerState<RunDetailPage> {
  bool isEditingTitle = false;
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    final result = ref.read(runResultProvider);
    _titleController = TextEditingController(text: getDefaultTitle(result?.startTime));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String getDefaultTitle(DateTime? time) {
    if (time == null) return "";
    final weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    final hour = time.hour;
    final ampm = hour < 12 ? '오전' : '오후';
    final weekday = weekdays[time.weekday - 1];
    return "$weekday $ampm 러닝";
  }

  String getFormattedDate(DateTime? time) {
    if (time == null) return "";
    return DateFormat('yyyy. MM. dd. - HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(runResultProvider);
    if (result == null) {
      return Scaffold(
        body: Center(child: Text("러닝 기록이 없습니다")),
      );
    }

    final selectedSurface = ref.watch(runningSurfaceProvider);

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            ref.read(runResultProvider.notifier).state = null;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => RunMainPage()),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (_) => CupertinoActionSheet(
                  title: Text("러닝 기록"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        print("삭제됨");
                      },
                      isDestructiveAction: true,
                      child: Text("삭제"),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () => Navigator.pop(context),
                    child: Text("취소"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getFormattedDate(result.startTime),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gap.ss,
            InkWell(
              onTap: () => setState(() => isEditingTitle = true),
              child: Row(
                children: [
                  Expanded(
                    child: isEditingTitle
                        ? TextField(
                            controller: _titleController,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.trackyIndigo),
                            onSubmitted: (_) => setState(() => isEditingTitle = false),
                          )
                        : Text(
                            _titleController.text,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.trackyIndigo),
                          ),
                  ),
                  Icon(isEditingTitle ? Icons.check : Icons.edit, size: 20),
                ],
              ),
            ),
            Divider(color: Colors.grey[400]),
            Gap.m,

            RunSummarySection(result: result),
            Gap.l,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RunInfoItem(label: '평균 페이스', value: result.averagePace),
                ),
                Expanded(
                  child: RunInfoItem(label: '시간', value: result.time),
                ),
                Expanded(
                  child: RunInfoItem(label: '칼로리', value: '${result.calories}'),
                ),
              ],
            ),
            Gap.xl,

            RunMapSection(paths: result.paths),
            Gap.xl,

            RunGoalRowSection(result: result),
            Gap.xl,

            RunMetaTile(
              title: "러닝 강도",
              trailing: (() {
                final intensity = ref.watch(runIntensityProvider);
                return intensity == null
                    ? Icon(Icons.add)
                    : Text("$intensity/10", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
              })(),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const IntensityPage())),
            ),
            RunMetaTile(
              title: "러닝 장소",
              trailing: selectedSurface == null
                  ? Icon(Icons.add)
                  : Icon(getSurfaceIcon(selectedSurface), color: AppColors.trackyIndigo),
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
              showMemo: true,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MemoPage())),
            ),
          ],
        ),
      ),
    );
  }
}

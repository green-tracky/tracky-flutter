// run_result_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_goal_row.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_info.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_map.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_mata_tile.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/widgets/run_summary.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class RunResultPage extends ConsumerWidget {
  const RunResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(runResultProvider);

    if (result == null || result.distance == 0.0) {
      return Scaffold(
        backgroundColor: AppColors.trackyBGreen,
        appBar: AppBar(
          backgroundColor: AppColors.trackyBGreen,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.trackyIndigo),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => RunMainPage()),
                (route) => false,
              );
            },
          ),
        ),
        body: Center(
          child: Text(
            "러닝 결과가 없습니다.",
            style: TextStyle(color: AppColors.trackyIndigo, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        title: Text("러닝 결과", style: TextStyle(color: AppColors.trackyIndigo)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RunSummarySection(result: result),
            Gap.l,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RunInfoItem(
                    label: '평균 페이스',
                    value: result.averagePace,
                  ),
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
            RunMetaTile(title: "러닝 강도"),
            RunMetaTile(title: "러닝 장소"),
            RunMetaTile(title: "메모", showMemo: true),
          ],
        ),
      ),
    );
  }
}

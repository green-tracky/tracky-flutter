import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page_vm.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/section_page_vm.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/run_section_back_button.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/run_section_row.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/run_section_tab_bar.dart';

class RunSectionPage extends ConsumerWidget {
  const RunSectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(runSectionProvider); // 실시간 섹션
    final runState = ref.watch(runRunningProvider); // 실시간 시간

    final time = runState.maybeWhen(
      data: (run) => run.time,
      orElse: () => 0,
    );

    String formattedTime(int seconds) {
      final min = seconds ~/ 60;
      final sec = seconds % 60;
      return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
    }

    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.xxl,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '구간',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.trackyIndigo,
                ),
              ),
            ),
            Gap.xl,
            const RunSectionTabBar(),
            Gap.s,
            const Divider(thickness: 1, color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  return RunSectionRow(section: sections[index]);
                },
              ),
            ),
            RunSectionBackButton(formattedTime: formattedTime(time)),
          ],
        ),
      ),
    );
  }
}

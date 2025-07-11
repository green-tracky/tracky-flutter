import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';

import 'widgets/run_section_back_button.dart';
import 'widgets/run_section_row.dart';
import 'widgets/run_section_tab_bar.dart';

class RunSectionPage extends StatelessWidget {
  const RunSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                itemCount: _dummySections.length,
                itemBuilder: (context, index) {
                  return RunSectionRow(section: _dummySections[index]);
                },
              ),
            ),
            const RunSectionBackButton(),
          ],
        ),
      ),
    );
  }
}

final List<RunSection> _dummySections = [
  RunSection(kilometer: 1.0, pace: '5:12', variation: -3),
  RunSection(kilometer: 2.0, pace: '5:30', variation: 6),
  RunSection(kilometer: 3.0, pace: '5:18', variation: -2),
  RunSection(kilometer: 4.0, pace: '5:25', variation: 1),
];

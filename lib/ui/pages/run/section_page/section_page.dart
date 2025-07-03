import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/data/model/Run.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/button/section_bottom.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_row.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_tab_menu.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_title.dart';

class RunSectionPage extends ConsumerWidget {
  const RunSectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummySections = [
      RunSection(kilometer: 1.0, pace: '5:12', variation: -3),
      RunSection(kilometer: 2.0, pace: '5:30', variation: 6),
      RunSection(kilometer: 3.0, pace: '5:18', variation: -2),
      RunSection(kilometer: 4.0, pace: '5:25', variation: 1),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RunSectionTitle(),
            const RunSectionTabMenu(),
            const Divider(thickness: 1, color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: dummySections.length,
                itemBuilder: (context, index) => RunSectionRow(section: dummySections[index]),
              ),
            ),
            const RunSectionBottomButton(),
          ],
        ),
      ),
    );
  }
}

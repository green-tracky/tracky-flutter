import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_tab_bar.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_title.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_list_view.dart';
import 'package:tracky_flutter/ui/pages/run/section_page/widgets/section_back_button.dart';

class RunSectionPage extends StatelessWidget {
  const RunSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            SectionTitle(),
            SizedBox(height: 20),
            SectionTabMenu(
              tabs: ['킬로미터', '페이스', '편차'],
              onTabSelected: (label) {
                // TODO: 탭 선택 처리
              },
            ),
            SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey),
            SectionListView(sections: _dummySections),
            SectionBackButton(
              onPressed: () => Navigator.pop(context),
              label: '00:42',
            ),
          ],
        ),
      ),
    );
  }
}

final _dummySections = [
  SectionData(kilometer: 1, pace: "5'01\"", variation: 0.2),
  SectionData(kilometer: 2, pace: "4'58\"", variation: -0.1),
  SectionData(kilometer: 3, pace: "5'12\"", variation: 0.3),
  SectionData(kilometer: 4, pace: "5'05\"", variation: -0.2),
  SectionData(kilometer: 5, pace: "5'00\"", variation: -0.1),
];

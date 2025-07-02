import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity/activity.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity/show_all_button.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/records.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/tabbar.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/year_month_selector.dart';
import 'recent.dart';
import 'activity/activity_button.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) => Container(
          color: Color(0xFFF9FAEB),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Tabbar(),
              SizedBox(height: 10),
              YearMonthSelector(

                onChanged: (y, m) {
                  // 여기서 (y, m) 값을 활용하거나 Provider/Bloc 등에 전달
                  debugPrint('ActivityBody에서 받은 날짜: $y-$m');
                },
              ),
              Activity(),
              SizedBox(height: 100),
              Recent(),
              AcitivityButton(),
              Records(),
              ShowAllButton(),
            ],
          ),
        ),
      ),
    );
  }
}

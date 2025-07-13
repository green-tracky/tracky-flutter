import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity_appbar.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity_body.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ActivityAppbar(),
      body: ActivityBody(),
    );
  }
}

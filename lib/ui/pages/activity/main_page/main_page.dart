import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity_body.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ActivityBody(),
    );
  }




  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.account_box_rounded),
      ),
      title: Text("활동"),
      centerTitle: true,
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add))],
    );
  }
}
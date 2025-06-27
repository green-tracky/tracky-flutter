import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike1/activity_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ActivityPage());
  }
}

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

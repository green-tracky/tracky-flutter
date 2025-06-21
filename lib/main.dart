import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

// 기본 구조 : 추후 작성하고 옮길 것
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Placeholder());
  }
}

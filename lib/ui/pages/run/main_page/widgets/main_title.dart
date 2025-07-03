import 'package:flutter/material.dart';

Widget buildTitle() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Text(
      '러닝',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFF021F59)),
    ),
  );
}

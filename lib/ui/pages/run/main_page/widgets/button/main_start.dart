import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

Positioned buildstartbutton(BuildContext context) {
  return Positioned(
    bottom: 150,
    left: 0,
    right: 0,
    child: Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RunRunningPage()));
        },
        borderRadius: BorderRadius.circular(60),
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(color: Color(0xFFD0F252), shape: BoxShape.circle),
          child: Center(
            child: Text(
              '시작',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
            ),
          ),
        ),
      ),
    ),
  );
}

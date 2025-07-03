import 'package:flutter/material.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              children: [
                Text(
                  "_'__\"",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text('페이스', style: TextStyle(fontSize: 16, color: Color(0xFF021F59))),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Column(
              children: [
                Text(
                  '00:08',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text('시간', style: TextStyle(fontSize: 16, color: Color(0xFF021F59))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

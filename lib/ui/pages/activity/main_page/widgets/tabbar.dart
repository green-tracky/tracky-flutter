import 'package:flutter/material.dart';

class Tabbar extends StatelessWidget {

  const Tabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // 배경색
        borderRadius: BorderRadius.circular(12), // 라운딩 처리
        border: Border(
          bottom: BorderSide.none, // 아래 선 없애기
        ),
      ),
      padding: EdgeInsets.all(4), // 탭 간격을 위해 padding
      child: Container(
        height: 30,
        child: TabBar(
          tabs: const <Widget>[
            Tab(text: "주"),
            Tab(text: "월"),
            Tab(text: "년"),
            Tab(text: "전체"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(8),
          ),
          indicatorSize:
          TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,   // Flutter 3.7+
          dividerHeight: 0,                  // 혹시 모를 높이도 0

          // 기본 인디케이터 라인도 혹시 몰라 꺼둡니다
          indicatorColor: Colors.transparent,
          indicatorWeight: 0,
        ),
      ),
    );
  }
}

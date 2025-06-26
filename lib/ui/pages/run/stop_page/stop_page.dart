import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/main_page/main_page.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

class RunStopPage extends StatelessWidget {
  const RunStopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonAppBar(),
      endDrawer: CommunityDrawer(),
      backgroundColor: Color(0xFFF9FAEB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 110),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '러닝',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xFF021F59)),
            ),
          ),
          SizedBox(height: 20),

          // 지도 배경
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // 지도 배경 (샘플 이미지)
                // TODO: 나중에 컨테이너 다 지우고 구글 맵 넣기
                Container(
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Text('지도 영역', style: TextStyle(color: Colors.black54, fontSize: 16)),
                ),

                // 시작 버튼 (
                Positioned(
                  bottom: 240,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RunMainPage()));
                    },
                    borderRadius: BorderRadius.circular(50),
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

                // 하단 버튼
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          print("설정 클릭됨");
                        },
                        icon: Icon(Icons.settings, color: Colors.black, size: 25),
                        label: Text("설정", style: TextStyle(color: Colors.black, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          minimumSize: Size(120, 50),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          print("목표설정 클릭됨");
                        },
                        icon: Icon(Icons.settings, color: Colors.black, size: 25),
                        label: Text("목표설정", style: TextStyle(color: Colors.black, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          minimumSize: Size(120, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

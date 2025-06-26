import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';
import 'package:tracky_flutter/ui/pages/run/stop_page/stop_page.dart';

class RunPausedPage extends StatelessWidget {
  const RunPausedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB), // 배경색
      body: SafeArea(
        child: Column(
          children: [
            // 지도 영역
            Container(
              height: screenHeight * 0.5,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: Text('지도 영역', style: TextStyle(color: Colors.black54, fontSize: 16)),
            ),

            SizedBox(height: 40),

            // 지표 정보
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMetricColumn("0.00", "킬로미터"),
                  _buildMetricColumn("00:47", "시간"),
                  _buildMetricColumn("_'_\"", "평균 페이스"),
                ],
              ),
            ),

            SizedBox(height: 120),

            // 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleButton(Icons.stop, Colors.black, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RunStopPage()));
                }),
                SizedBox(width: 100),
                _buildCircleButton(Icons.play_arrow, Color(0xFFD0F252), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RunRunningPage()));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }

  Widget _buildCircleButton(IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}

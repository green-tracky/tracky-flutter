import 'package:flutter/material.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSectionPage extends StatelessWidget {
  const RunSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            // 제목
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '구간',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF021F59)),
              ),
            ),

            SizedBox(height: 20),
            // 탭 메뉴
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildTab('킬로미터'), _buildTab('페이스'), _buildTab('편차')],
              ),
            ),

            SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey),

            // 더미 구간 리스트
            Expanded(
              child: ListView.builder(
                itemCount: _dummySections.length,
                itemBuilder: (context, index) {
                  final section = _dummySections[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${section.kilometer} km', style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
                        Text(section.pace, style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
                        Text('${section.variation}', style: TextStyle(fontSize: 18, color: Color(0xFF021F59))),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 하단 버튼
            Padding(
              padding: EdgeInsets.only(bottom: 80.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD0F252),
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    minimumSize: Size(120, 50),
                    elevation: 2,
                  ),
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  label: Text('00:42', style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w700),
    );
  }
}

// 더미 리스트
final List<RunSection> _dummySections = [
  RunSection(kilometer: 1.0, pace: '5:12', variation: -3),
  RunSection(kilometer: 2.0, pace: '5:30', variation: 6),
  RunSection(kilometer: 3.0, pace: '5:18', variation: -2),
  RunSection(kilometer: 4.0, pace: '5:25', variation: 1),
];

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB), // 전체 배경색
      // AppBar 사용
      appBar: CommonAppBar(),
      endDrawer: CommunityDrawer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 리더보드 텍스트
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 14),
            child: Text(
              '리더보드',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF021F59),
              ),
            ),
          ),

          // 검정 배경 전체 박스
          Expanded(
            child: Stack(
              children: [
                // 배경 이미지
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/run_1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 어두운 반투명 레이어
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withAlpha(135), // 투명도 조절 가능 0~255
                ),

                // 내용
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      // 제목 박스
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '친구가 많을 수록\n더 멀리 달릴 수 있습니다.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // 소제목 박스
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '달리기 친구들과 함께 리더보드를\n공유하고 비교하며 경쟁해보세요.\n서로를 위한 최고의 동기부여를 제공합니다.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: 48),

                      // 버튼 박스
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: Color(0xFFD0F252),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('친구 찾기 및 초대'),
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

      // 하단 탭바
      // bottomNavigationBar: CommonBottomNav(),
    );
  }
}

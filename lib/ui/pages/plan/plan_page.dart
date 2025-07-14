import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/plan/widgets/icon_column.dart';
import 'package:tracky_flutter/ui/pages/plan/widgets/plan_box.dart';
import 'package:tracky_flutter/ui/pages/plan/widgets/video_widget.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Container(),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF9FAEB),

      body: SafeArea(
        //위의 Appbar영역에 침범하지 않이 위함
        child: ScrollConfiguration(
          // ListView의 스크롤 위치 바(스크롤 인디케이터) 가 나오지 않게
          behavior: ScrollConfiguration.of(
            context,
          ).copyWith(scrollbars: false),
          child: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: PlanBox(
                    imagePath: 'assets/images/plan.jpg',
                    title: '6주 10K 트레이닝 플랜',
                    subtitle: '6주 트레이닝 플랜',
                    description:
                        'After Dark Tour에 참여하거나 10K 완주를 목표로\n'
                        '한다면 이 플랜으로 도움을 받아보세요. 편안한 러닝과\n'
                        '스피드 러닝, 장거리 러닝 등 다양한 트레이닝을 통해\n'
                        '더 즐겁게 달릴 수 있을 거예요.',
                    levelLabel: '중급',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: PlanBox(
                    imagePath: 'assets/images/plan2.jpg',
                    title: 'Run Beyond 플랜',
                    subtitle: '4주 트레이닝 플랜',
                    description:
                        '페이스나 거리가 러닝의 전부는 아닙니다. 때론 그보다\n'
                        '더 큰 가치를 발견할 수 있답니다.이 플랜을 통해 새로운\n'
                        '목적의 러닝을 해보세요\n',
                    levelLabel: '모든레벨',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Text(
                      '트라키 트레이닝 플랜은 여러분의 목표 달성을 돕기 위해\n'
                      '매주 코칭과 가이드를 제공합니다.',
                      style: TextStyle(
                        color: Colors.black,
                        height: 2,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: IconColumn(),
                ),
                SizedBox(height: 70),
                Divider(thickness: 1, color: Colors.black12),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Text(
                      "트라키 트레이닝 철학",
                      style: TextStyle(
                        color: Colors.black,
                        height: 2,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: VideoWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
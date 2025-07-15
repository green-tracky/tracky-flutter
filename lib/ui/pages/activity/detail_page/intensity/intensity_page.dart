import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/detail_vm.dart';

class IntensityPage extends ConsumerStatefulWidget {
  const IntensityPage({super.key});

  @override
  ConsumerState<IntensityPage> createState() => _IntensityPageState();
}

class _IntensityPageState extends ConsumerState<IntensityPage> {
  int current = 1;

  final intensityList = [
    ["극도로 가벼움", "가벼운 스트레칭 수준"],
    ["매우 낮음", "천천히 걷는 수준"],
    ["낮음", "돌아다니며 편안하게 호흡할 수 있는 수준"],
    ["보통", "대화를 나눌 수 있는 가벼운 운동 수준"],
    ["상당함", "호흡이 거칠어지고 심박수가 증가하는 수준"],
    ["어려움", "대화가 버거우며 호흡이 어려운 수준"],
    ["높음", "대화가 어려우며 운동이 힘든 수준"],
    ["매우 높음", "호흡이 힘들며 전신이 지치는 수준"],
    ["극도로 어려움", "대화가 불가능하며 한계에 다다른 수준"],
    ["최대치", "일을 할 수 없을 정도의 가장 힘든 수준"],
  ];

  @override
  void initState() {
    super.initState();
    final saved = ref.read(runIntensityProvider);
    if (saved != null) current = saved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("화요일 오전 러닝"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              ref.read(runIntensityProvider.notifier).state = current;
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Spacer(),
          Text(
            "$current",
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD0F252),
            ),
          ),
          Text(
            intensityList[current - 1][0],
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 6),
          Text(
            intensityList[current - 1][1],
            style: TextStyle(color: Colors.white70),
          ),
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.height / 4, // 유지 가능
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: _CustomIntensitySlider(
              current: current,
              onChanged: (val) {
                setState(() {
                  current = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomIntensitySlider extends StatelessWidget {
  final int current;
  final Function(int) onChanged;

  const _CustomIntensitySlider({
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final total = 10;

    return LayoutBuilder(
      builder: (context, constraints) {
        final segmentWidth = constraints.maxWidth / total;

        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            final dx = details.localPosition.dx;
            final newIndex = (dx / constraints.maxWidth * total)
                .clamp(1, total)
                .round();
            onChanged(newIndex);
          },
          child: SizedBox(
            height: 80, // 필요한 경우 여기 높이 조절
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                // 형광색 선택 영역
                Container(
                  width: segmentWidth * current,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFD0F252),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      topRight: current == total
                          ? Radius.circular(12)
                          : Radius.zero,
                      bottomRight: current == total
                          ? Radius.circular(12)
                          : Radius.zero,
                    ),
                  ),
                ),

                // 숫자 중앙 배치
                Row(
                  children: List.generate(total, (i) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "${i + 1}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

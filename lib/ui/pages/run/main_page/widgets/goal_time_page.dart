import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class GoalTimePage extends ConsumerStatefulWidget {
  const GoalTimePage({super.key});

  @override
  ConsumerState<GoalTimePage> createState() => _GoalTimePageState();
}

class _GoalTimePageState extends ConsumerState<GoalTimePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      _focusNode.requestFocus(); // 키보드 자동 포커스
    });
  }

  String getFormattedTime(String input) {
    final padded = input.padLeft(4, '0').substring(0, 4);
    final hours = padded.substring(0, 2);
    final minutes = padded.substring(2, 4);
    return "$hours:$minutes";
  }

  @override
  Widget build(BuildContext context) {
    final text = _controller.text;
    final display = getFormattedTime(text);

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text('목표 시간', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              final input = _controller.text.padLeft(4, '0').substring(0, 4);
              final hour = int.tryParse(input.substring(0, 2)) ?? 0;
              final minute = int.tryParse(input.substring(2, 4)) ?? 0;
              final totalMinutes = hour * 60 + minute;

              if (totalMinutes > 0) {
                ref.read(runGoalValueProvider.notifier).state = totalMinutes.toDouble();
                Navigator.pop(context);
              }
            },
            child: Text("설정", style: TextStyle(color: Color(0xFF021F59))),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),

            // 설명
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "시간을 설정하고 러닝을 마치는",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "순간까지 동기 부여를 받으세요.",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // 시간 텍스트 표시
            Text(display, style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
            Container(margin: EdgeInsets.only(top: 4), width: 200, height: 1, color: Colors.black),
            SizedBox(height: 8),
            Text("시간 : 분", style: TextStyle(fontSize: 16)),

            // 예상 거리
            if (text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "당신의 예상 거리: ${(int.tryParse(text) ?? 0) * 0.079} 킬로미터",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

            SizedBox(height: 20),

            // 숫자 키패드
            SizedBox(
              width: 1,
              height: 1,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                cursorColor: Colors.transparent,
                style: TextStyle(color: Colors.transparent),
                decoration: InputDecoration(border: InputBorder.none, counterText: ""),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

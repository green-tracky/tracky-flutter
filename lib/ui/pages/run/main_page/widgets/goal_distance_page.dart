import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class GoalDistancePage extends ConsumerStatefulWidget {
  const GoalDistancePage({super.key});

  @override
  ConsumerState<GoalDistancePage> createState() => _GoalDistancePageState();
}

class _GoalDistancePageState extends ConsumerState<GoalDistancePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  static const double averageSpeedKmPerHour = 4.75;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      _focusNode.requestFocus();
    });
  }

  Duration? calculateExpectedDuration() {
    final km = double.tryParse(_controller.text);
    if (km == null || km <= 0) return null;

    final hours = km / averageSpeedKmPerHour;
    return Duration(seconds: (hours * 3600).round());
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes % 60)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    final inputText = _controller.text;
    final distance = double.tryParse(inputText) ?? 0;
    final duration = calculateExpectedDuration();

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text('목표 거리', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              final rawText = _controller.text.trim();
              final value = double.tryParse(rawText.isEmpty ? '0' : rawText); // 빈 값이면 0으로 처리

              ref.read(runGoalTypeProvider.notifier).state = RunGoalType.distance;
              ref.read(runGoalValueProvider.notifier).state = value ?? 0.0;

              Navigator.pop(context);
            },
            child: Text("설정", style: TextStyle(color: Color(0xFF021F59))),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "거리를 설정하고 동기 부여를 받아",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "결승선을 통과하세요.",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              Text(distance.toStringAsFixed(2), style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
              Container(margin: EdgeInsets.only(top: 4), width: 180, height: 1, color: Colors.black),
              SizedBox(height: 8),
              Text("킬로미터", style: TextStyle(fontSize: 16)),

              if (duration != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("당신의 예상 운동 시간: ${formatDuration(duration)}", style: TextStyle(color: Colors.black54)),
                ),

              SizedBox(height: 20),

              // 숨겨진 입력창
              SizedBox(
                width: 1,
                height: 1,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(2)],
                  cursorColor: Colors.transparent,
                  style: TextStyle(color: Colors.transparent),
                  decoration: InputDecoration(border: InputBorder.none, counterText: ""),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

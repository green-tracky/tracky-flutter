// pause_page/widgets/paused_control_buttons.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/widgets/pause_result.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

import '../../../stop_page/stop_page.dart';

class PausedControlButtons extends ConsumerStatefulWidget {
  const PausedControlButtons({super.key});

  @override
  ConsumerState<PausedControlButtons> createState() => _PausedControlButtonsState();
}

class _PausedControlButtonsState extends ConsumerState<PausedControlButtons> {
  Timer? _longPressTimer;
  bool _isLongPressTriggered = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')));
          },
          onLongPressStart: (_) {
            _isLongPressTriggered = false;
            _longPressTimer = Timer(Duration(seconds: 3), () {
              _isLongPressTriggered = true;

              final distance = ref.read(runDistanceProvider);
              if (distance == 0.0) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("기록된 러닝이 없어 저장하지 않았어요")));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => RunMainPage()),
                  (route) => false,
                );
                return;
              }

              finishRun(context, ref);

              ref.read(runGoalTypeProvider.notifier).state = null;
              ref.read(runGoalValueProvider.notifier).state = null;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => RunDetailPage()),
                (route) => false,
              );
            });
          },
          onLongPressEnd: (_) {
            _longPressTimer?.cancel();
            if (!_isLongPressTriggered) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')));
            }
          },
          child: Ink(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: Icon(Icons.stop, color: Colors.white, size: 32),
          ),
        ),
        SizedBox(width: 100),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => RunRunningPage()));
          },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: Color(0xFFD0F252), shape: BoxShape.circle),
            child: Icon(Icons.play_arrow, color: Colors.white, size: 32),
          ),
        ),
      ],
    );
  }
}

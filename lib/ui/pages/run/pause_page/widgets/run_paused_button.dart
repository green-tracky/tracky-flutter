import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/run/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/service/run_result_service.dart';
import 'package:tracky_flutter/ui/pages/run/result_page/result_page.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/ui/pages/run/running_page/running_page.dart';

class RunPausedButtons extends ConsumerStatefulWidget {
  const RunPausedButtons({super.key});

  @override
  ConsumerState<RunPausedButtons> createState() => _RunPausedButtonsState();
}

class _RunPausedButtonsState extends ConsumerState<RunPausedButtons> {
  Timer? _longPressTimer;
  bool _isLongPressTriggered = false;

  void _onStopPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')),
    );
  }

  void _onLongPressStart(BuildContext context) {
    _isLongPressTriggered = false;

    _longPressTimer = Timer(Duration(seconds: 3), () {
      _isLongPressTriggered = true;

      saveRunResult(context, ref);

      ref.read(runGoalTypeProvider.notifier).state = null;
      ref.read(runGoalValueProvider.notifier).state = null;

      final result = ref.read(runResultProvider);

      final hasData = result != null && result.distance >= 0.01;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => hasData ? RunDetailPage() : RunResultPage()),
        (route) => false,
      );
    });
  }

  void _onLongPressEnd(BuildContext context) {
    _longPressTimer?.cancel();
    if (!_isLongPressTriggered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _onStopPressed(context),
          onLongPressStart: (_) => _onLongPressStart(context),
          onLongPressEnd: (_) => _onLongPressEnd(context),
          child: Ink(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: Icon(Icons.stop, color: Colors.white, size: 32),
          ),
        ),
        SizedBox(width: 100),
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RunRunningPage()),
          ),
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

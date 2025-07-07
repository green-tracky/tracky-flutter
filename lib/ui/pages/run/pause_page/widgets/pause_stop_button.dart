import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/run/pause_page/pause_no_record_page.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class StopRunButton extends ConsumerStatefulWidget {
  final VoidCallback onFinish;
  const StopRunButton({super.key, required this.onFinish});

  @override
  ConsumerState<StopRunButton> createState() => _StopRunButtonState();
}

class _StopRunButtonState extends ConsumerState<StopRunButton> {
  Timer? _longPressTimer;
  bool _isLongPressTriggered = false;

  void _handleLongPressStart(BuildContext context) {
    _isLongPressTriggered = false;
    _longPressTimer = Timer(Duration(seconds: 3), () {
      _isLongPressTriggered = true;

      ref.read(runGoalTypeProvider.notifier).state = null;
      ref.read(runGoalValueProvider.notifier).state = null;

      widget.onFinish();

      final distance = ref.read(runDistanceProvider);
      if (distance == 0.0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => NoRunRecordPage()),
              (route) => false,
        );
        return;
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => RunDetailPage()),
            (route) => false,
      );
    });
  }

  void _handleLongPressEnd(BuildContext context) {
    _longPressTimer?.cancel();
    if (!_isLongPressTriggered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('정지를 위해 3초 이상 길게 눌러주세요')),
        );
      },
      onLongPressStart: (_) => _handleLongPressStart(context),
      onLongPressEnd: (_) => _handleLongPressEnd(context),
      child: Ink(
        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        width: 64,
        height: 64,
        child: Icon(Icons.stop, color: Colors.white, size: 32),
      ),
    );
  }
}

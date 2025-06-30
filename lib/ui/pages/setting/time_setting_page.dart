import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';
import 'package:tracky_flutter/utils/my_utils.dart';

class TimeSettingPage extends ConsumerStatefulWidget {
  final int initialValue;

  const TimeSettingPage({super.key, required this.initialValue});

  @override
  ConsumerState<TimeSettingPage> createState() => _TimeSettingPageState();
}

class _TimeSettingPageState extends ConsumerState<TimeSettingPage> {
  final FocusNode _focusNode = FocusNode();
  String input = "";

  @override
  void initState() {
    super.initState();

    final hours = widget.initialValue ~/ 3600;
    final minutes = (widget.initialValue % 3600) ~/ 60;

    input = '${hours.toString().padLeft(2, '0')}${minutes.toString().padLeft(2, '0')}';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      _focusNode.requestFocus();
    });

    Future.delayed(Duration(milliseconds: 200), () {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatted = formatTimeInput(input);

    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: Colors.black),
        title: Text("시간 선택", style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              final totalSeconds = convertToTotalSeconds(input);
              ref.read(runGoalTypeProvider.notifier).state = RunGoalType.time;
              ref.read(runGoalValueProvider.notifier).state = totalSeconds.toDouble();

              Navigator.pop(context);
            },
            child: Text("저장", style: TextStyle(color: Color(0xFF021F59))),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 60),
          Text(
            formatted,
            style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),
          Text("시간 : 분", style: TextStyle(fontSize: 20)),
          SizedBox(height: 100),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.4,
            padding: EdgeInsets.symmetric(horizontal: 48),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: [
              for (var i = 1; i <= 9; i++) _buildKey(i.toString()),
              SizedBox.shrink(),
              _buildKey("0"),
              _buildKey("⌫", isBackspace: true),
            ],
          ),
          Spacer(),
          SizedBox(height: 24),
          SizedBox(
            width: 1,
            height: 1,
            child: TextField(
              focusNode: _focusNode,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              cursorColor: Colors.transparent,
              style: TextStyle(color: Colors.transparent),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String label, {bool isBackspace = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          if (isBackspace) {
            if (input.isNotEmpty) input = input.substring(0, input.length - 1);
          } else {
            if (input.length >= 4) {
              input = input.substring(1);
            }
            input += label;
          }
        });
      },
      child: Center(
        child: isBackspace
            ? Icon(Icons.backspace, size: 28)
            : Text(
                label,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
              ),
      ),
    );
  }
}

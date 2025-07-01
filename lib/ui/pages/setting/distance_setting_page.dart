import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/run/run_vm.dart';

class DistanceSettingPage extends ConsumerStatefulWidget {
  final double initialDistance;

  const DistanceSettingPage({
    super.key,
    this.initialDistance = 5.0,
  });

  @override
  ConsumerState<DistanceSettingPage> createState() => _DistanceSettingPageState();
}

class _DistanceSettingPageState extends ConsumerState<DistanceSettingPage> {
  final FocusNode _focusNode = FocusNode();
  String distance = "";

  void initState() {
    super.initState();
    distance = "";

    Future.delayed(Duration(milliseconds: 200), () {
      _focusNode.requestFocus();
    });
  }

  void _addDigit(String digit) {
    setState(() {
      if (digit == ".") {
        if (!distance.contains(".")) {
          if (distance.isEmpty) {
            distance = "0.";
          } else {
            distance += ".";
          }
        }
      } else {
        if (distance.contains(".")) {
          final dotIndex = distance.indexOf(".");
          // 소수점 이하 2자리까지만 허용
          if (distance.length - dotIndex <= 2) {
            distance += digit;
          }
        } else {
          if (distance.length < 3) {
            distance += digit;
          }
        }
      }
    });
  }

  void _removeDigit() {
    setState(() {
      if (distance.isNotEmpty) {
        distance = distance.substring(0, distance.length - 1);
      }
    });
  }

  Widget _buildNumberKey(String value, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        title: Text("거리 선택"),
        centerTitle: true,
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0.5,
      ),
      body: Column(
        children: [
          SizedBox(height: 60),
          Text(
            distance.isEmpty ? widget.initialDistance.toStringAsFixed(2) : distance,
            style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),
          Text("Km", style: TextStyle(fontSize: 20)),
          SizedBox(height: 100),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.4,
            padding: EdgeInsets.symmetric(horizontal: 48),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: [
              for (var i = 1; i <= 9; i++) _buildNumberKey(i.toString(), () => _addDigit(i.toString())),
              _buildNumberKey(".", () => _addDigit(".")),
              _buildNumberKey("0", () => _addDigit("0")),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _removeDigit,
                child: Center(
                  child: Icon(Icons.backspace, size: 28),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(48),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () {
                final parsed = double.tryParse(
                  distance.isEmpty ? widget.initialDistance.toStringAsFixed(2) : distance,
                );
                if (parsed != null) {
                  ref.read(runGoalTypeProvider.notifier).state = RunGoalType.distance;
                  ref.read(runGoalValueProvider.notifier).state = parsed;

                  Future.microtask(() {
                    Navigator.pop(context, parsed);
                  });
                }
              },
              child: Text(
                "저장",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

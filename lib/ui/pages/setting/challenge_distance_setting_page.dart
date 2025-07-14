import 'package:flutter/material.dart';

class ChallengeDistanceSettingPage extends StatefulWidget {
  final double initialDistance;

  const ChallengeDistanceSettingPage({
    super.key,
    this.initialDistance = 5.0,
  });

  @override
  State<ChallengeDistanceSettingPage> createState() =>
      _ChallengeDistanceSettingPageState();
}

class _ChallengeDistanceSettingPageState
    extends State<ChallengeDistanceSettingPage> {
  final FocusNode _focusNode = FocusNode();
  String distance = "";

  @override
  void initState() {
    super.initState();
    distance = "";
    Future.delayed(const Duration(milliseconds: 200), () {
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
          style: const TextStyle(
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
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
        title: const Text("거리 선택"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF9FAEB),
        elevation: 0.5,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            distance.isEmpty
                ? widget.initialDistance.toStringAsFixed(2)
                : distance,
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
          ),
          const Text("Km", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 100),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.4,
            padding: const EdgeInsets.symmetric(horizontal: 48),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: [
              for (var i = 1; i <= 9; i++)
                _buildNumberKey(i.toString(), () => _addDigit(i.toString())),
              _buildNumberKey(".", () => _addDigit(".")),
              _buildNumberKey("0", () => _addDigit("0")),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _removeDigit,
                child: const Center(
                  child: Icon(Icons.backspace, size: 28),
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: () {
                final parsed = double.tryParse(
                  distance.isEmpty
                      ? widget.initialDistance.toStringAsFixed(2)
                      : distance,
                );
                if (parsed != null) {
                  Navigator.pop(context, parsed);
                }
              },
              child: const Text(
                "저장",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

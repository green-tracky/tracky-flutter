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
  final FocusNode _focusNode = FocusNode(); // This focus node is not used with the current setup
  String distance = "";

  @override
  void initState() {
    super.initState();
    // Initialize distance with initialDistance if it's set, otherwise keep empty for user input
    // If you want the initial value to be displayed immediately, set `distance` to `widget.initialDistance.toString()`
    // For now, it keeps `distance` empty so user input starts from scratch or shows `initialDistance` when `distance` is empty.
    distance = "";
    // Removed `_focusNode.requestFocus()` as there's no TextField for it to focus on.
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
          // Allow up to two decimal places
          if (distance.length - dotIndex <= 2) {
            distance += digit;
          }
        } else {
          // Limit whole number part to 3 digits (e.g., 999)
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
            // If distance is empty, show initialDistance formatted to two decimal places
            // Otherwise, show the user's input
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
                // Parse the current distance string.
                // If empty, use initialDistance. Otherwise, parse the user's input.
                final parsed = double.tryParse(
                  distance.isEmpty
                      ? widget.initialDistance.toStringAsFixed(2)
                      : distance,
                );
                if (parsed != null) {
                  Navigator.pop(context, parsed); // Return the parsed double
                } else {
                  // Optionally show an error if parsing fails (e.g., "0.")
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid distance.")),
                  );
                }
              },
              child: const Text(
                "저장", // Changed to English
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
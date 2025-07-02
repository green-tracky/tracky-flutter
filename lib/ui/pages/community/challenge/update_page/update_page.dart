import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/end_time_setting_page.dart';

class ChallengeUpdatePage extends StatefulWidget {
  final String initialName;
  final int initialImageIndex;

  const ChallengeUpdatePage({
    super.key,
    required this.initialName,
    required this.initialImageIndex,
  });

  @override
  State<ChallengeUpdatePage> createState() => _ChallengeUpdatePageState();
}

class _ChallengeUpdatePageState extends State<ChallengeUpdatePage> {
  late int selectedImageIndex;
  late TextEditingController nameController;

  final List<int> imageOptions = [1, 2, 3]; // 실제 이미지로 교체 가능

  bool get isFormChanged =>
      nameController.text.trim().isNotEmpty &&
      (nameController.text.trim() != widget.initialName ||
          selectedImageIndex != widget.initialImageIndex);

  @override
  void initState() {
    super.initState();
    selectedImageIndex = widget.initialImageIndex;
    nameController = TextEditingController(text: widget.initialName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
        title: const Text("챌린지 편집하기"),
        backgroundColor: const Color(0xFFF9FAEB),
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF021F59),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: imageOptions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final image = entry.value;
                  final isSelected = selectedImageIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedImageIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: isSelected ? 220 : 200,
                        height: isSelected ? 200 : 175,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.grey[400]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFD0F252)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                "$image",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Positioned(
                                top: 6,
                                right: 6,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFD0F252),
                                  size: 24,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "챌린지 이름 정하기",
              suffixIcon: Icon(Icons.edit),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text(
              "거리",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.grey),
            subtitle: const Text("1km", style: TextStyle(color: Colors.grey)),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "기간",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.grey),
            subtitle: const Text(
              "6월 30일 - 7월 1일",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Spacer(),
          const Text("챌린지를 생성한 후에는 친구를 초대할 수 있습니다."),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: isFormChanged ? _updateChallenge : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormChanged
                    ? const Color(0xFFD0F252)
                    : Colors.black45,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(
                "업데이트",
                style: TextStyle(
                  color: isFormChanged ? const Color(0xFF021F59) : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _updateChallenge() {
    print("챌린지 업데이트 완료!");
  }
}

import 'package:flutter/material.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/end_time_setting_page.dart';

class ChallengeCreatePage extends StatefulWidget {
  const ChallengeCreatePage({super.key});

  @override
  State<ChallengeCreatePage> createState() => _ChallengeCreatePageState();
}

class _ChallengeCreatePageState extends State<ChallengeCreatePage> {
  int? selectedImageIndex;
  String? challengeName;
  String? selectedDistance;
  String? selectedDate;

  final List<int> imageOptions = [1, 2, 3]; // 실제 이미지로 교체 가능

  bool get isFormValid =>
      challengeName != null &&
      challengeName!.isNotEmpty &&
      selectedDistance != null &&
      selectedDate != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
        title: const Text("챌린지 만들기"),
        backgroundColor: const Color(0xFFF9FAEB),
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          // 이미지 리스트 영역
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF021F59),
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
          // 챌린지 이름
          TextField(
            onChanged: (value) => setState(() => challengeName = value.trim()),
            decoration: const InputDecoration(
              hintText: "챌린지 이름 정하기",
              suffixIcon: Icon(Icons.edit),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          // 거리 선택
          ListTile(
            title: const Text("거리 선택", style: TextStyle(fontWeight: FontWeight.w700),),
            trailing: const Icon(Icons.add),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DistanceSettingPage()),
              );
              if (result != null) {
                setState(() => selectedDistance = result);
              }
            },
            subtitle: selectedDistance != null ? Text(selectedDistance!) : null,
          ),
          const Divider(),
          // 날짜 선택
          ListTile(
            title: const Text("날짜 선택", style: TextStyle(fontWeight: FontWeight.w700),),
            trailing: const Icon(Icons.add),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EndTimeSettingPage()),
              );
              if (result != null) {
                setState(() => selectedDate = result);
              }
            },
            subtitle: selectedDate != null ? Text(selectedDate!) : null,
          ),
          const Spacer(),
          const Text("챌린지를 생성한 후에는 친구를 초대할 수 있습니다."),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: isFormValid ? _createChallenge : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid
                    ? const Color(0xFFD0F252)
                    : Colors.black45,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(
                "챌린지 만들기",
                style: TextStyle(
                  color: isFormValid
                      ? Color(0xFF021F59)
                      : Colors.white, // ✅ 상태별 텍스트 색상
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

  void _createChallenge() {
    // 챌린지 생성 로직
    print("챌린지 생성 완료!");
  }
}

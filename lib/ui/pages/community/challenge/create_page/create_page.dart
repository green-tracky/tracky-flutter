import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/create_page/create_fm.dart';
import 'package:tracky_flutter/ui/pages/setting/challenge_distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/distance_setting_page.dart';
import 'package:tracky_flutter/ui/pages/setting/end_time_setting_page.dart';

class ChallengeCreatePage extends StatefulWidget {
  const ChallengeCreatePage({super.key});

  @override
  State<ChallengeCreatePage> createState() => _ChallengeCreatePageState();
}

class _ChallengeCreatePageState extends State<ChallengeCreatePage> {
  final List<int> imageOptions = [1, 2, 3]; // 실제 이미지로 교체 가능

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
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(challengeCreateProvider);
          final notifier = ref.read(challengeCreateProvider.notifier);

          final isFormValid = state.isValid;

          return Column(
            children: [
              // 이미지 리스트
              Container(
                width: double.infinity,
                height: 250,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: const BoxDecoration(color: Color(0xFF021F59)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: imageOptions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final image = entry.value;
                      final isSelected = state.imageIndex == index;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () => notifier.setImageIndex(index),
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
                                Text(
                                  "$image",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
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

              // 챌린지 이름 입력
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (value) => notifier.setChallengeName(value.trim()),
                  decoration: const InputDecoration(
                    hintText: "챌린지 이름 정하기",
                    suffixIcon: Icon(Icons.edit),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 거리 선택
              ListTile(
                title: const Text(
                  "거리 선택",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(Icons.add),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChallengeDistanceSettingPage(),
                    ),
                  );
                  if (result != null) {
                    notifier.setDistance(result);
                  }
                },
                subtitle: state.distance != null
                    ? Text("${state.distance} km")
                    : null,
              ),
              const Divider(),

              // 날짜 선택
              ListTile(
                title: const Text(
                  "날짜 선택",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                trailing: const Icon(Icons.add),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EndTimeSettingPage(),
                    ),
                  );
                  if (result != null) {
                    final parts = result.split('~');
                    if (parts.length == 2) {
                      notifier.setStartDate(parts[0].trim());
                      notifier.setEndDate(parts[1].trim());
                    }
                  }
                },
                subtitle: state.startDate != null && state.endDate != null
                    ? Text("${state.startDate} ~ ${state.endDate}")
                    : null,
              ),

              const Spacer(),

              const Text("챌린지를 생성한 후에는 친구를 초대할 수 있습니다."),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () => notifier.submitChallenge(ref, context)
                      : null,
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
                          ? const Color(0xFF021F59)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

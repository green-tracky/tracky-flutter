import 'package:flutter/material.dart';

class ChallengeInfoPage extends StatelessWidget {
  const ChallengeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('챌린지 정보', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color(0xFFF9FAEB),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: const [
          ChallengeInfoSection(
            title: "목표",
            description: "공식 챌린지는 Tracky가 목표를 임의로 설정합니다. 사용자 지정 챌린지의 경우 해당 사용자가 직접 목표를 설정할 수 있습니다.",
          ),
          SizedBox(height: 32),
          ChallengeInfoSection(
            title: "시작 및 종료",
            description:
                "공식 챌린지의 시작일과 종료일은 Tracky에서 설정합니다. 사용자 지정 챌린지의 경우 해당 사용자가 직접 시작일과 종료일을 설정할 수 있습니다. 챌린지에 참여 중인 경우, 러닝을 기록하면 거리가 자동으로 반영됩니다.",
          ),
          SizedBox(height: 32),
          ChallengeInfoSection(
            title: "챌린지 참여 및 종료",
            description:
                "챌린지에 등록하려면 '챌린지 참여하기' 버튼을 탭하세요. 챌린지가 진행되는 동안 언제든지 챌린지 메뉴를 통해 종료할 수 있습니다. 챌린지를 종료하면 해당 챌린지에서 했던 모든 활동 내역이 삭제됩니다.",
          ),
          SizedBox(height: 32),
          ChallengeInfoSection(
            title: "챌린지 완료",
            description:
                "챌린지를 완료하려면 챌린지 목표를 달성해야 합니다. 챌린지를 완료하면 해당 챌린지와 관련된 리워드를 받을 수 있는 자격이 부여됩니다.",
          ),
          SizedBox(height: 32),
          ChallengeInfoSection(
            title: "달성 기록 및 리워드",
            description:
                "챌린지에는 달성 기록과 보상이 따를 수 있습니다. 달성 기록과 보상은 챌린지 목표를 달성할 때 제공됩니다.",
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class ChallengeInfoSection extends StatelessWidget {
  final String title;
  final String description;

  const ChallengeInfoSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

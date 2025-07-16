import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/gvm/session_gvm.dart';
import 'package:tracky_flutter/ui/pages/auth/join/join_complete_page/join_complete_page.dart';
import 'package:tracky_flutter/ui/pages/auth/join/widgets/join_button.dart';

class JoinPage extends ConsumerStatefulWidget {
  const JoinPage({super.key});

  @override
  ConsumerState<JoinPage> createState() => _UserInfoInputPageState();
}

class _UserInfoInputPageState extends ConsumerState<JoinPage> {
  String? selectedGender;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool get isNextButtonVisible =>
      selectedGender != null && heightController.text.isNotEmpty && weightController.text.isNotEmpty;

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_bg.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildJoinBody(),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildJoinBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap.xxl,
        const Text(
          '사용자 정보 입력',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Gap.s,
        Text(
          selectedGender == null ? '맞춤형 피트니스 분석을 위한 성별 정보를 입력해주세요.' : '러닝 거리, 페이스, 칼로리 소모량 등 정확한 결과를 위해 추가 정보가 필요해요.',
          style: const TextStyle(color: Colors.white70, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Gap.xxl,
        _buildGenderButton('남성'),
        Gap.s,
        _buildGenderButton('여성'),
        Gap.xl,
        if (selectedGender != null) ...[
          _buildInputField('키 (cm)', heightController),
          Gap.s,
          _buildInputField('체중 (kg)', weightController),
          Gap.xl,
          if (isNextButtonVisible)
            JoinButton(
              onPressed: () {
                final gender = selectedGender!;
                final height = double.tryParse(heightController.text) ?? 0;
                final weight = double.tryParse(weightController.text) ?? 0;

                // 세션 업데이트
                ref.read(sessionProvider.notifier).editUserInfo(gender, height, weight);

                // 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const JoinCompletePage(),
                  ),
                );
              },
            ),
        ],
      ],
    );
  }

  Widget _buildGenderButton(String gender) {
    final bool isSelected = selectedGender == gender;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.transparent,
          side: const BorderSide(color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            selectedGender = gender;
          });
        },
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: (_) => setState(() {}),
    );
  }
}

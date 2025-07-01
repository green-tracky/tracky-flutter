import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditingPage extends StatefulWidget {
  const ProfileEditingPage({super.key});

  @override
  State<ProfileEditingPage> createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  final TextEditingController nameController = TextEditingController(
    text: '김건우',
  );
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  File? _profileImage;
  final String gender = '남성'; // 혹은 '여성'

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("취소", style: TextStyle(color: Colors.black)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: 저장 로직
              Navigator.pop(context);
            },
            child: const Text("저장", style: TextStyle(color: Colors.black)),
          ),
        ],
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF9FAEB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // 프로필 이미지 선택
            GestureDetector(
              onTap: _pickImage,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black12,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(height: 8),
                  const Text('편집', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 이름 입력
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  '성별',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 성별 (수정 불가)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(value: gender == '남성', onChanged: null),
                      const Text(
                        '남성',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(value: gender == '여성', onChanged: null),
                      const Text(
                        '여성',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 키 / 몸무게
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: heightController,
                    decoration: const InputDecoration(
                      labelText: '키 (cm)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      labelText: '몸무게 (kg)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 활동 지역
            TextField(
              controller: regionController,
              decoration: const InputDecoration(
                labelText: '활동 지역',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // 자기소개
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: '자기소개',
                border: OutlineInputBorder(),
              ),
              maxLength: 150,
              maxLines: 3,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

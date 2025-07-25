import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_invite_page/friend_invite_page.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_list_page/friend_list_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // 또는 ImageSource.camera
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAEB),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 20),

            /// 클릭 가능한 프로필 이미지
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: _imageFile == null
                    ? const Icon(
                        Icons.camera_alt,
                        color: Colors.white70,
                        size: 32,
                      )
                    : ClipOval(
                        child: Image.file(
                          _imageFile!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 12),
            const Text(
              "김건우",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/update/profile");
              },
              child: const Text("프로필 수정"),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconWithText(Icons.person_add, "친구", () {
                  final dummyFriends = ['ssar', 'cos'];
                  final hasFriends = dummyFriends.isNotEmpty;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => hasFriends ? const ListFriendPage() : const InviteFriendPage(),
                    ),
                  );
                }),
                _iconWithText(Icons.groups, "커뮤니티", () {
                  Navigator.pushNamed(context, "/community");
                }),
                _iconWithText(Icons.settings, "설정", () {
                  Navigator.pushNamed(context, "/settings");
                }),
              ],
            ),

            const SizedBox(height: 36),
            ListTile(
              title: const Text("수신함"),
              subtitle: const Text("메시지 보기"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/messages');
              },
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE2F5D2), // 진한 녹색 계열
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '회원 가입일 : ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF021F59),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '2024년 6월 1일', // ← 실제 데이터
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF021F59),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWithText(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(onPressed: onTap, icon: Icon(icon, size: 30)),
        Text(label),
      ],
    );
  }
}

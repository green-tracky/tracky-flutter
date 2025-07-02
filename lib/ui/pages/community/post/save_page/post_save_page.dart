import 'dart:io' as io;
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracky_flutter/ui/pages/community/post/list_page/list_page.dart';

class PostSavePage extends StatefulWidget {
  const PostSavePage({super.key});

  @override
  State<PostSavePage> createState() => _PostSavePageState();
}

class _PostSavePageState extends State<PostSavePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String? selectedRunning;
  List<String> runningList = ['러닝 기록 1', '러닝 기록 2', '러닝 기록 3'];

  final ImagePicker _picker = ImagePicker();
  List<io.File> _selectedFiles = []; // 모바일용 파일
  List<Uint8List> _webImages = []; // 웹용 이미지

  /// ✅ 이미지 개수 (getter)
  int get imageCount => kIsWeb ? _webImages.length : _selectedFiles.length;

  /// ✅ 이미지 미리보기 위젯
  Widget buildImagePreview(int index) {
    if (kIsWeb) {
      return Image.memory(
        _webImages[index],
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        _selectedFiles[index],
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }

  /// ✅ 이미지 삭제
  void removeImage(int index) {
    setState(() {
      if (kIsWeb) {
        _webImages.removeAt(index);
      } else {
        _selectedFiles.removeAt(index);
      }
    });
  }

  /// ✅ 이미지 선택
  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('사진 찍기'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    if (kIsWeb) {
                      final bytes = await pickedFile.readAsBytes();
                      setState(() {
                        _webImages.add(bytes);
                      });
                    } else {
                      setState(() {
                        _selectedFiles.add(io.File(pickedFile.path));
                      });
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('사진 선택'),
                onTap: () async {
                  Navigator.pop(context);
                  final List<XFile> pickedFiles = await _picker.pickMultiImage();
                  if (pickedFiles.isNotEmpty) {
                    if (kIsWeb) {
                      final futures = await Future.wait(pickedFiles.map((e) => e.readAsBytes()));
                      setState(() {
                        _webImages.addAll(futures);
                      });
                    } else {
                      setState(() {
                        _selectedFiles.addAll(pickedFiles.map((e) => io.File(e.path)));
                      });
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ 등록 버튼 동작
  void handleSave() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (selectedRunning == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('러닝을 선택해주세요')),
      );
      return;
    }

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('내용을 입력해주세요')),
      );
      return;
    }

    print('제목: $title');
    print('내용: $content');
    print('러닝: $selectedRunning');
    print('사진 개수: $imageCount');

    // ✅ 게시글 목록 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PostListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF021F59)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          '글쓰기',
          style: TextStyle(color: Color(0xFF021F59), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 러닝 선택
            DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF021F59)),
                  borderRadius: BorderRadius.circular(4),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              isExpanded: true,
              hint: const Text(
                '러닝을 선택해주세요',
                style: TextStyle(fontSize: 14),
              ),
              items: runningList
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                  .toList(),
              value: selectedRunning,
              onChanged: (value) {
                setState(() {
                  selectedRunning = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 0),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),

            const Divider(),

            // 본문 입력
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 16),

            /// ✅ 본문 아래에 사진 미리보기
            if (imageCount > 0)
              GridView.builder(
                itemCount: imageCount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 3개
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 9 / 16, // 비율 유지
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 9 / 16,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: buildImagePreview(index),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black45, // ✅ 반투명 배경
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 22,
                            ),
                            onPressed: () => removeImage(index),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 66,
        height: 66,
        child: FloatingActionButton(
          onPressed: showImagePicker,
          backgroundColor: Colors.white,
          elevation: 2,
          child: const Icon(
            Icons.add_a_photo,
            color: Color(0xFF021F59),
            size: 28,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD0F252), // 등록 버튼 색상
            elevation: 2,
            foregroundColor: Color(0xFF021F59),
            minimumSize: const Size.fromHeight(60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            '등록하기',
            style: TextStyle(color: Color(0xFF021F59), fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

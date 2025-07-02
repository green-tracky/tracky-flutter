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
  List<io.File> _selectedFiles = [];
  List<Uint8List> _webImages = [];

  int currentIndex = 0;

  int get imageCount => kIsWeb ? _webImages.length : _selectedFiles.length;

  void removeImage(int index) {
    setState(() {
      if (kIsWeb) {
        _webImages.removeAt(index);
      } else {
        _selectedFiles.removeAt(index);
      }
      if (currentIndex >= imageCount) {
        currentIndex = imageCount - 1;
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

    String? imageUrl;

    if (!kIsWeb && _selectedFiles.isNotEmpty) {
      imageUrl = _selectedFiles.first.path;
    } else if (kIsWeb && _webImages.isNotEmpty) {
      imageUrl = "web_image_${DateTime.now().millisecondsSinceEpoch}";
      // 웹 이미지 메모리로 관리하는 건 UI에서만 가능 (업로드 기능 붙이면 수정)
    }

    final newPost = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "author": "me",
      "content": content,
      "createdAt": DateTime.now().toString().substring(0, 16),
      "likesCount": 0,
      "commentsCount": 0,
      "isLiked": false,
      "imageUrl": imageUrl,
    };

    Navigator.pop(context, newPost);
  }

  /// ✅ 이미지 슬라이더 (인스타그램 스타일)
  Widget buildImageSlider() {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 3 / 4; // ✅ 4:3 비율

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: imageHeight, // 이미지 영역 고정
            child: PageView.builder(
              itemCount: imageCount,
              controller: PageController(viewportFraction: 1), // 여백 제거
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Stack(
                    children: [
                      Container(
                        child: Center(
                          child: ClipRRect(
                            child: FittedBox(
                              fit: BoxFit.contain, // ✅ 이미지 비율 유지
                              child: kIsWeb
                                  ? Image.memory(_webImages[index])
                                  : Image.file(
                                      _selectedFiles[index],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black, size: 20),
                            onPressed: () => removeImage(index),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          /// 인디케이터
          if (imageCount > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageCount, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: currentIndex == index ? 8 : 6,
                  height: currentIndex == index ? 8 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? const Color(0xFF021F59) : Colors.grey,
                  ),
                );
              }),
            ),
        ],
      ),
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
            DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF021F59)),
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
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black54,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),

            const Divider(),

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

            if (imageCount > 0) buildImageSlider(),
          ],
        ),
      ),

      /// 사진 추가 버튼
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

      // 게시글 등록 버튼
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD0F252), // 등록 버튼 색상
            elevation: 4,
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

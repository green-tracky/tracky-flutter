import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostUpdatePage extends StatefulWidget {
  final String initialTitle;
  final String initialContent;
  final String selectedRunning;
  final List<String> imageUrls;

  const PostUpdatePage({
    super.key,
    required this.initialTitle,
    required this.initialContent,
    required this.selectedRunning,
    required this.imageUrls,
  });

  @override
  State<PostUpdatePage> createState() => _PostUpdatePageState();
}

class _PostUpdatePageState extends State<PostUpdatePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final ImagePicker _picker = ImagePicker();

  List<io.File> _selectedFiles = [];
  List<Uint8List> _webImages = [];
  int currentIndex = 0;

  int get imageCount => kIsWeb ? _webImages.length : _selectedFiles.length;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);

    if (!kIsWeb) {
      _selectedFiles = widget.imageUrls.map((e) => io.File(e)).toList();
    }
    // 웹이면 네트워크 이미지 메모리로 불러오기 필요
  }

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

  void handleUpdate() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

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
    }

    final updatedPost = {
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
    };

    Navigator.pop(context, updatedPost);
  }

  Widget buildImageSlider() {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 3 / 4;

    return Column(
      children: [
        SizedBox(
          height: imageHeight,
          child: PageView.builder(
            itemCount: imageCount,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: kIsWeb ? Image.memory(_webImages[index]) : Image.file(_selectedFiles[index]),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => removeImage(index),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAEB),
      appBar: AppBar(
        title: const Text('글 수정'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF9FAEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF021F59)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: widget.selectedRunning,
              enabled: false,
              decoration: InputDecoration(
                labelText: '러닝',
                labelStyle: const TextStyle(color: Colors.black),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF021F59)),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
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
              maxLines: null,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            if (imageCount > 0) buildImageSlider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showImagePicker,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add_a_photo, color: Color(0xFF021F59)),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: handleUpdate,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD0F252),
            foregroundColor: const Color(0xFF021F59),
            minimumSize: const Size.fromHeight(60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text('수정하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

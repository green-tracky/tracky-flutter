import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';

class PostUpdatePage extends StatefulWidget {
  final String initialContent;
  final String selectedRunning;

  const PostUpdatePage({
    super.key,
    required this.initialContent,
    required this.selectedRunning,
  });

  @override
  State<PostUpdatePage> createState() => _PostUpdatePageState();
}

class _PostUpdatePageState extends State<PostUpdatePage> {
  late TextEditingController _contentController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.initialContent);
  }

  void handleUpdate() {
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('내용을 입력해주세요')),
      );
      return;
    }

    final updatedPost = {
      "content": content,
    };

    Navigator.pop(context, updatedPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        title: Text(
          '글 수정',
          style: styleWithColor(
            AppTextStyles.appBarTitle,
            AppColors.trackyIndigo,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.trackyIndigo),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextFormField(
              initialValue: widget.selectedRunning,
              enabled: false,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.trackyIndigo),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(_focusNode);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.trackyBGreen,
                child: TextField(
                  controller: _contentController,
                  focusNode: _focusNode,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: handleUpdate,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.trackyNeon,
            elevation: 4,
            foregroundColor: AppColors.trackyIndigo,
            minimumSize: const Size.fromHeight(60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            '수정하기',
            style: styleWithColor(
              AppTextStyles.semiTitle,
              AppColors.trackyIndigo,
            ),
          ),
        ),
      ),
    );
  }
}

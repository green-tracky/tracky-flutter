import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';

class PostSavePage extends StatefulWidget {
  const PostSavePage({super.key});

  @override
  State<PostSavePage> createState() => _PostSavePageState();
}

class _PostSavePageState extends State<PostSavePage> {
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? selectedRunning;
  List<String> runningList = ['러닝 기록 1', '러닝 기록 2', '러닝 기록 3'];

  void handleSave() {
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

    final newPost = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "running": selectedRunning,
      "content": content,
    };

    Navigator.pop(context, newPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.trackyIndigo),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          '글쓰기',
          style: styleWithColor(
            AppTextStyles.appBarTitle,
            AppColors.trackyIndigo,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.trackyIndigo),
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
                        style: TextStyle(fontSize: 14),
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
                  color: AppColors.trackyIndigo,
                ),
                iconSize: Gap.xlGap,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
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
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: handleSave,
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
            '등록하기',
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

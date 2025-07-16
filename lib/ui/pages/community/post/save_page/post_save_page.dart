import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/_core/utils/text_style_util.dart';
import 'package:tracky_flutter/ui/pages/community/post/save_page/widgets/post_save_fm.dart';

class PostSavePage extends ConsumerWidget {
  final int? postId;

  const PostSavePage({super.key, this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postSaveAsync = ref.watch(postSaveProvider(postId));

    return postSaveAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(body: Center(child: Text("에러 : \$error"))),
      data: (state) => _PostSaveBody(postId: postId),
    );
  }
}

class _PostSaveBody extends ConsumerStatefulWidget {
  final int? postId;
  const _PostSaveBody({required this.postId});

  @override
  ConsumerState<_PostSaveBody> createState() => _PostSaveBodyState();
}

class _PostSaveBodyState extends ConsumerState<_PostSaveBody> {
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(postSaveProvider(widget.postId).notifier);
    final state = ref.watch(postSaveProvider(widget.postId)).value!;

    final runningList = state.runRecordOptions;
    final selectedId = state.runRecordId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_contentController.text != state.content) {
        _contentController.text = state.content;
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              child: DropdownButtonFormField2<int>(
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
                      (item) => DropdownMenuItem<int>(
                        value: item.id,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              item.createdAt,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                value: selectedId,
                onChanged: (value) {
                  if (value != null) vm.updateRunRecordId(value);
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
                    onChanged: vm.updateContent,
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
            onPressed: () async {
              try {
                await vm.savePost();
                if (context.mounted) Navigator.pop(context, true);
              } catch (e, stack) {
                print(e);
                print(stack);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
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
              style: styleWithColor(AppTextStyles.semiTitle, AppColors.trackyIndigo),
            ),
          ),
        ),
      ),
    );
  }
}

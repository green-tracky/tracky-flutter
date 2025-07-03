import 'package:flutter/material.dart';

class PostSavePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSave;

  const PostSavePageAppBar({super.key, required this.onSave});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAEB),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF021F59)),
        onPressed: () => Navigator.pop(context),
        padding: const EdgeInsets.only(left: 16),
        iconSize: 20,
      ),
      title: const Text(
        '글쓰기',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF021F59),
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onSave,
            child: const Text(
              '등록',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

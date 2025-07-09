import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class AddFriendAppBar extends StatelessWidget {
  final bool isSearching;
  final TextEditingController controller;
  final Function(String) onSubmit;
  final VoidCallback onToggleSearch;
  final VoidCallback onClose;

  const AddFriendAppBar({
    super.key,
    required this.isSearching,
    required this.controller,
    required this.onSubmit,
    required this.onToggleSearch,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trackyBGreen,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: onClose,
          ),
          Expanded(
            child: Center(
              child: isSearching
                  ? TextField(
                      controller: controller,
                      autofocus: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: '태그로 친구 검색',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onSubmitted: onSubmit,
                    )
                  : const Text(
                      '친구 추가',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF021F59),
                      ),
                    ),
            ),
          ),
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.black,
            ),
            onPressed: onToggleSearch,
          ),
        ],
      ),
    );
  }
}

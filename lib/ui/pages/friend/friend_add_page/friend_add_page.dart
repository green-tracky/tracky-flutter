import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/widgets/friend_app_bar.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/widgets/friend_result_list.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/widgets/friend_search_bar.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AddFriendAppBar(
          isSearching: isSearching,
          controller: searchController,
          onSubmit: (value) {
            setState(() {
              query = value.trim();
            });
          },
          onToggleSearch: () {
            setState(() {
              if (isSearching) {
                searchController.clear();
                query = '';
              }
              isSearching = !isSearching;
            });
          },
          onClose: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Divider(height: 1, thickness: 1, color: Colors.grey.shade400),
          Expanded(
            child: Center(
              child: query.isEmpty ? const AddFriendSearchGuide() : AddFriendResultList(tag: query),
            ),
          ),
        ],
      ),
    );
  }
}

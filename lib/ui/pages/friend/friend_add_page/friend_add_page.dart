import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/widgets/friend_app_bar.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_add_page/widgets/friend_result_list.dart';

class AddFriendPage extends ConsumerStatefulWidget {
  const AddFriendPage({super.key});

  @override
  ConsumerState<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends ConsumerState<AddFriendPage> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
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
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          Expanded(
            child: Center(
              child: query.isEmpty
                  ? const Text('태그를 입력하세요\n예: #ssar, #green', textAlign: TextAlign.center)
                  : AddFriendResultList(tag: query),
            ),
          ),
        ],
      ),
    );
  }
}

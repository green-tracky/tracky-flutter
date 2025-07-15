import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/friend_detail_page.dart';

import '../../friend_vm.dart'; // ViewModel 임포트
import 'friend_list_tile.dart';

class AddFriendResultList extends ConsumerStatefulWidget {
  final String tag;

  const AddFriendResultList({super.key, required this.tag});

  @override
  ConsumerState<AddFriendResultList> createState() => _AddFriendResultListState();
}

class _AddFriendResultListState extends ConsumerState<AddFriendResultList> {
  String? _lastTag;

  @override
  void initState() {
    super.initState();
    _searchIfNeeded(widget.tag);
  }

  @override
  void didUpdateWidget(AddFriendResultList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tag != widget.tag) {
      _searchIfNeeded(widget.tag);
    }
  }

  void _searchIfNeeded(String tag) {
    if (tag.isNotEmpty && tag != _lastTag) {
      _lastTag = tag;
      Future.microtask(() => ref.read(searchFriendProvider.notifier).search(tag));
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchFriendProvider);

    return searchState.when(
      data: (users) {
        if (users.isEmpty) {
          return Center(child: Text('"${widget.tag}" 태그로 검색된 친구 없음'));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return AddFriendListTile(
              name: user.username,
              email: user.userTag,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailFriendPage(name: user.username, email: user.userTag),
                  ),
                );
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('검색 오류: $e')),
    );
  }
}

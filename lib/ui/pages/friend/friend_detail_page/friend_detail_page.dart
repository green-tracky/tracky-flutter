import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/widgets/friend_header.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/widgets/friend_info.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_vm.dart';

import '../friend_list_page/friend_list_page.dart';

class DetailFriendPage extends ConsumerWidget {
  final String name;
  final String email;
  final int userId;
  final bool isFriend;

  const DetailFriendPage({
    super.key,
    required this.name,
    required this.email,
    required this.userId,
    this.isFriend = false,
  });

  void _showDeleteDialog(BuildContext context, WidgetRef ref, int toUserId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          '친구 삭제',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        content: Text(
          '$name님을(를) 친구에서 삭제하시겠습니까?',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              '취소',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text(
              '친구 삭제',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            onPressed: () async {
              Navigator.of(ctx).pop(); // 다이얼로그 닫기
              try {
                await ref.read(friendRepositoryProvider).deleteFriend(toUserId);
                Navigator.of(context).pop(); // 이전 화면 닫기
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$name님이 친구 목록에서 삭제되었습니다')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('삭제 실패: $e')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.trackyBGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          '친구 정보',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              children: [
                DetailFriendHeader(
                  name: name,
                  isFriend: isFriend,
                  onDelete: () => _showDeleteDialog(context, ref, userId),
                  // TODO : 친구 추가 및 Firebase 알림 추가
                  // VM 연결해서 친구 ID 받아서 전송 후 Firebase 알림 보내기
                  // FcmService(navigatorKey: navigatorKey).sendTestFriendRequest();
                  onAdd: () async {
                    try {
                      await ref.read(friendRepositoryProvider).inviteFriend(userId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name님에게 친구 요청을 보냈습니다')),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const ListFriendPage()),
                        (route) => route.isFirst,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('친구 요청 실패: $e')),
                      );
                    }
                  },
                ),
                Gap.xl,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: DetailFriendInfoBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

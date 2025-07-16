import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/friend/friend_detail_page/widgets/challenge_detail_friend_header.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_detail_page/widgets/friend_info.dart';
import 'package:tracky_flutter/ui/pages/friend/friend_vm.dart';

import '../friend_list_page/challenge_friend_list_page.dart';
import '../friend_vm.dart';

// 챌린지 초대 상태를 관리하기 위한 StateProvider
// userId를 키로, 초대되었는지 여부를 값으로 가집니다.
final challengeInvitationStatusProvider = StateProvider<Map<int, bool>>((ref) => {});

class ChallengeFriendDetailPage extends ConsumerWidget {
  final int challengeId;
  final String name;
  final String email;
  final int userId;
  final bool isFriend;

  const ChallengeFriendDetailPage({
    super.key,
    required this.challengeId,
    required this.name,
    required this.email,
    required this.userId,
    this.isFriend = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 userId에 대한 챌린지 초대 상태를 감시합니다.
    final invitedStatus = ref.watch(challengeInvitationStatusProvider)[userId] ?? false;

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
                // 새로운 ChallengeDetailFriendHeader 위젯 사용
                ChallengeDetailFriendHeader(
                  name: name,
                  isFriend: isFriend,
                  isChallengeInvited: invitedStatus,
                  onAdd: invitedStatus // 이미 요청을 보냈으면 버튼을 비활성화 (null 전달)
                      ? null
                      : () async {
                    try {
                      // 챌린지 초대 요청
                      await ref.read(challengeRepositoryProvider).inviteChallenge(challengeId, userId);
                      // 초대 상태를 true로 업데이트하여 UI를 변경합니다.
                      ref.read(challengeInvitationStatusProvider.notifier).update((state) {
                        return {...state, userId: true};
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name님에게 챌린지 초대 요청을 보냈습니다.')),
                      );
                      // 친구 목록 페이지로 돌아가고 이전 스택을 모두 제거합니다.
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => ChallengeFriendListPage(challengeId: challengeId,)),
                            (route) => route.isFirst,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('챌린지 초대 요청 실패: $e')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 40), // Gap.xl 대신 SizedBox 사용 예시
              ],
            ),
          ),
        ),
      ),
    );
  }
}
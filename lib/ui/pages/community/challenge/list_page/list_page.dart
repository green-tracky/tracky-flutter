import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/challenge_list_vm.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/widgets/challenge_banner.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/widgets/challenge_invitation_body.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/widgets/challenge_title.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/list_page/widgets/create_challenge_button.dart';
import 'package:tracky_flutter/ui/widgets/common_appbar.dart';
import 'package:tracky_flutter/ui/widgets/common_drawer.dart';

class ChallengeListPage extends ConsumerWidget {
  const ChallengeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeListProvider);

    return Scaffold(
      appBar: CommonAppBar(),
      endDrawer: CommunityDrawer(),
      backgroundColor: AppColors.trackyBGreen,
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("에러 발생: $err")),
        data: (model) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChallengeTitle(),
                Gap.m,
                if (model.recommendedChallenge != null)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChallengeDetailPage(
                            challengeId: model.recommendedChallenge!.id,
                          ),
                        ),
                      );
                    },
                    child: ChallengeBanner(),
                  ),
                Gap.s,
                if (model.inviteChallenges.isNotEmpty)
                  ChallengeInvitationBody(
                    inviteChallenges: model.inviteChallenges,
                  ),
                Gap.m,
                CreateChallengeButton(),
                Gap.xl,
                const Text(
                  "나의 챌린지",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF021F59),
                  ),
                ),
                const SizedBox(height: 8),
                ...buildChallengeCards(model.myChallenges, context),
                const Divider(height: 32),
                const Text(
                  "챌린지 참여하기",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF021F59),
                  ),
                ),
                ...buildChallengeCards(model.joinableChallenges, context),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> buildChallengeCards(
    List<ChallengeSummary> challenges,
    BuildContext context,
  ) {
    return challenges.map((c) {
      final isJoined = c.myDistance != null;
      final totalDistance = (c.targetDistance != null)
          ? "${(c.targetDistance! / 1000).toStringAsFixed(1)}km"
          : "";
      final progress = (c.myDistance != null)
          ? "${(c.myDistance! / 1000).toStringAsFixed(1)}km"
          : "";
      final dDay = (c.remainingTime != null && c.remainingTime > 0)
          ? "D-${(c.remainingTime / 86400).floor()}"
          : "마감됨";

      return Card(
        color: const Color(0xFFF9FAEB),
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChallengeDetailPage(challengeId: c.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                      "assets/images/challenge_achievement.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF021F59),
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (!isJoined && (c.sub?.isNotEmpty ?? false))
                        Text(
                          c.sub!,
                          style: const TextStyle(color: Color(0xFF021F59)),
                        ),
                      if (isJoined)
                        Text(
                          "$progress / $totalDistance",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      Text(
                        dDay,
                        style: const TextStyle(color: Color(0xFF021F59)),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF021F59),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}

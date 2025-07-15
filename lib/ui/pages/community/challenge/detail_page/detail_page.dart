import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/info_page/info_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/leaderboard_page/leaderboard_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/update_page/update_page.dart';
import 'package:tracky_flutter/ui/pages/community/challenge/detail_page/detail_page_vm.dart';

class ChallengeDetailPage extends ConsumerWidget {
  final int challengeId;

  ChallengeDetailPage({super.key, required this.challengeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(challengeDetailProvider(challengeId));

    return model.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('오류 발생: $err')),
      ),
      data: (model) => Scaffold(
        appBar: _appBar(context, model, ref),
        backgroundColor: AppColors.trackyBGreen,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(child: Placeholder()),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  "${(model!.remainingTime / 86400).floor()}일 남음",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  model.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  model.sub ?? '',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  "이번 달에 목표를 달성하고 완주자 기록을 달성하세요.",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              if (model.isInProgress)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text:
                                      "${model.myDistance?.toStringAsFixed(1) ?? "0"}km",
                                  style: const TextStyle(
                                    color: Color(0xFF021F59),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' / ',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 24,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${model.targetDistance?.toStringAsFixed(1) ?? "0"}km",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                            height: 40,
                            child: Placeholder(),
                          ),
                        ],
                      ),
                    ),
                    LinearProgressIndicator(
                      value: (model.targetDistance == 0)
                          ? 0
                          : ((model.myDistance ?? 0) /
                                    (model.targetDistance ?? 1))
                                .clamp(0.0, 1.0),
                      minHeight: 6,
                      color: const Color(0xFF021F59),
                      backgroundColor: const Color(0xFF021F59).withOpacity(0.2),
                    ),
                    const SizedBox(height: 32),
                    if (model.myDistance != 0 && model.rank != 0)
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "순위",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${model.rank} / ${model.participantCount}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Card(
                              color: const Color(0xFFF9FAEB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: Color(0xFF021F59),
                                ),
                              ),
                              child: ListTile(
                                title: const Text(
                                  "리더보드 보기",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF021F59),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Color(0xFF021F59),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LeaderboardPage(
                                        myRank: model.rank,
                                        leaderboard: model.leaderboard,
                                        totalDistance:
                                            model.targetDistance ?? 0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 32),
              const Text("총 거리", style: TextStyle(color: Colors.grey)),
              Text(
                "${model.targetDistance?.toStringAsFixed(1) ?? "0"}km",
                style: const TextStyle(fontSize: 16),
              ),
              if (model.isInProgress) ...[
                const SizedBox(height: 16),
                const Text("달린 거리", style: TextStyle(color: Colors.grey)),
                Text(
                  "${model.myDistance?.toStringAsFixed(1) ?? "0"}km",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
              const SizedBox(height: 16),
              const Text("운동 기간", style: TextStyle(color: Colors.grey)),
              Text(
                "${model.startDate}~${model.endDate}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text("참가자", style: TextStyle(color: Colors.grey)),
              Text(
                "${model.participantCount}명",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              const Text(
                "리워드 획득",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: Placeholder(),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name),
                      const Text(
                        "달성",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !model.isInProgress
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: FloatingActionButton.extended(
                  backgroundColor: const Color(0xFFD0F252),
                  onPressed: () {
                    // 참여 로직
                  },
                  label: const Text(
                    "챌린지 참여하기",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF021F59),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  AppBar _appBar(
    BuildContext context,
    ChallengeDetailModel? challenge,
    WidgetRef ref,
  ) {
    return AppBar(
      leading: const BackButton(),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showChallengeOptions(context, ref, challenge),
        ),
      ],
      backgroundColor: AppColors.trackyBGreen,
      elevation: 0,
    );
  }

  void _showChallengeOptions(
    BuildContext context,
    WidgetRef ref,
    ChallengeDetailModel? challenge,
  ) {
    if (challenge == null) return;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text("챌린지 옵션"),
        message: const Text("아래에서 원하는 작업을 선택하세요."),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const ChallengeInfoPage()),
              );
            },
            child: const Text("챌린지 정보", style: TextStyle(color: Color(0xFF007AFF))),
          ),
          if (challenge.isCreatedByMe)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChallengeUpdatePage(
                      challengeId: challenge.id,
                      initialName: challenge.name,
                      initialImageIndex: 0,
                    ),
                  ),
                ).then((updatedId) {
                  if (updatedId != null) {
                    // ✅ 상세 provider 갱신
                    ref.invalidate(challengeDetailProvider(updatedId));
                  }
                });
              },
              child: const Text(
                "챌린지 수정",
                style: TextStyle(color: Color(0xFF007AFF)),
              ),
            ),
          if (challenge.isInProgress)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                debugPrint("챌린지 종료");
              },
              child: const Text("챌린지 종료"),
            ),
          if (!challenge.isInProgress)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                debugPrint("챌린지 참가");
              },
              child: const Text("챌린지 참가", style: TextStyle(color: Color(0xFF007AFF))),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text("취소", style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.w100)),
        ),
      ),
    );
  }
}

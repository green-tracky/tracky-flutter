import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/detail_page/detail_page.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/running_badge_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/widgets/running_badge.dart';

class RunningBadgePage extends ConsumerWidget {
  const RunningBadgePage({super.key});

  @override
Widget build(BuildContext context, WidgetRef ref) {
  final asyncModel = ref.watch(runningBadgeProvider);

  return Scaffold(
    appBar: _appBar(context),
    backgroundColor: AppColors.trackyBGreen,
    body: asyncModel.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('에러 발생: $e')),
      data: (model) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('개인 기록'),
          _badgeGrid(model.bests, isPersonal: true),
          Gap.xl,
          _sectionTitle('월 러닝 거리'),
          _badgeGrid(model.monthly, isCountBased: true),
          Gap.xl,
          _sectionTitle('챌린지 기록'),
          _badgeGrid(model.challenges, isCountBased: true, isChallenge: true),
        ],
      ),
    ),
  );
}

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trackyBGreen,
      title: const Text('달성 기록', style: AppTextStyles.appBarTitle),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(title, style: AppTextStyles.semiTitle),
      );

  Widget _badgeGrid(
    List<Badge> items, {
    bool isPersonal = false,
    bool isCountBased = false,
    bool isChallenge = false,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        Color iconColor = item.isAchieved ? Colors.black : Colors.grey.shade400;
        if (isChallenge && item.isAchieved) {
          switch (item.name) {
            case '금메달':
              iconColor = const Color(0xFFFFD700);
              break;
            case '은메달':
              iconColor = const Color(0xFFC0C0C0);
              break;
            case '동메달':
              iconColor = const Color(0xFFCD7F32);
              break;
            default:
              iconColor = const Color(0xFFD0F252);
          }
        }

        return RunningBadge(
          label: item.name,
          date: item.formattedDate,
          achieved: item.isAchieved,
          iconColor: iconColor,
          isMine: item.isMine,
          count: item.achievedCount,
          isPersonal: isPersonal,
          isCountBased: isCountBased,
          isChallenge: isChallenge,
        );
      },
    );
  }
}

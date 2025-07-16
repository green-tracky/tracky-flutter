import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_card.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/record_widgets/record_to_all.dart';
import 'package:tracky_flutter/ui/pages/activity/running_badge_page/running_badge_vm.dart';

class Records extends ConsumerWidget {
  const Records({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(runningBadgeProvider);

    return model.when(
      data: (badgeModel) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white54,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RecordToAll(),
              const SizedBox(height: 12),
              ...badgeModel.recents.map((record) => RecordCard(record: record)).toList(),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('오류 발생: $err')),
    );
  }
}

// widgets/run_meta_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/activity_vm.dart';

class RunMetaTile extends ConsumerWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showMemo;

  const RunMetaTile({
    required this.title,
    this.trailing,
    this.onTap,
    this.showMemo = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memo = ref.watch(runMemoProvider);

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: showMemo && memo.trim().isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    memo,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              : null,
          trailing: showMemo
              ? (memo.trim().isNotEmpty ? Icon(Icons.note_alt_outlined, color: Colors.black) : Icon(Icons.add))
              : (trailing ?? Icon(Icons.add)),
          onTap: onTap,
        ),
        Divider(color: Colors.grey[400]),
        Gap.m,
      ],
    );
  }
}

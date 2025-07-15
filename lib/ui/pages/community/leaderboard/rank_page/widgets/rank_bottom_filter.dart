import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/rank_page/rank_vm.dart';

Future<dynamic> RankFilter(
  BuildContext context,
  List<String> options,
  String selected,
  WidgetRef ref,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.trackyBGreen,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.6,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: EdgeInsets.only(top: Gap.m.height!), // 16
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Gap.m, // SizedBox(height: 16)

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  '검색 기준',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.trackyIndigo,
                  ),
                ),
              ),

              ...options.map((option) {
                final isLast = option == options.last;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: RadioListTile<String>(
                        activeColor: AppColors.trackyIndigo,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          option,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.trackyIndigo,
                          ),
                        ),
                        value: option,
                        groupValue: ref.watch(rankFilterProvider), // Provider에서 groupValue 사용
                        onChanged: (value) {
                          if (value != null) {
                            ref.read(rankFilterProvider.notifier).state = value;
                            // 랭킹 데이터 새로 불러오기
                            ref.read(rankingProvider.notifier).fetchRankingData(value); // value가 필터 기준!
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    if (!isLast) Divider(thickness: 1),
                  ],
                );
              }).toList(),

              Gap.l,
            ],
          );
        },
      );
    },
  );
}

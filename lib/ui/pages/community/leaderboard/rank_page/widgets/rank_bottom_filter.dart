import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/community/leaderboard/leaderboard_vm.dart';

Future<dynamic> RankFilter(
  BuildContext context,
  List<String> options,
  String selected,
  WidgetRef ref,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color(0xFFF9FAEB),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8, // 처음에 보이는 비율 (0.8 = 80%)
        minChildSize: 0.6,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: EdgeInsets.only(top: 16),
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
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  '검색 기준',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF021F59),
                  ),
                ),
              ),
              ...options.map((option) {
                final isLast = option == options.last;
                return Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: RadioListTile<String>(
                        activeColor: Color(0xFF021F59),
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          option,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF021F59),
                          ),
                        ),
                        value: option,
                        groupValue: selected,
                        onChanged: (value) {
                          ref
                              .read(rankListProvider.notifier)
                              .changeFilter(value!);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    if (!isLast) Divider(thickness: 1),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
            ],
          );
        },
      );
    },
  );
}

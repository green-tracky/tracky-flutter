import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/list_page/filter/widgets/filter_title.dart';

class RunningFilterPage extends StatefulWidget {
  final String? selectedSort;
  final int? selectedYear;

  const RunningFilterPage({super.key, this.selectedSort, this.selectedYear});

  @override
  State<RunningFilterPage> createState() => _RunningFilterPageState();
}

class _RunningFilterPageState extends State<RunningFilterPage> {
  String? _sort;
  int? _year;

  final List<String> _sortOptions = [
    '최신순', // latest
    '오래된 순', // oldest
    '최장 거리', // distance-desc
    '최단 거리', // distance-asc
    '최고 페이스', // pace-asc
    '최저 페이스', // pace-desc
  ];

  final List<int> _yearOptions = [2025, 2024, 2023, 2022, 2021, 2020]; // now() ~ year(running[createdAt]) where id = 1

  @override
  void initState() {
    super.initState();
    _sort = widget.selectedSort ?? '최신순';
    _year = widget.selectedYear;
  }

  void _applyFilter() {
    Navigator.pop(context, {'sort': _sort, 'year': _year});
  }

  void _resetFilter() {
    setState(() {
      _sort = '최신순';
      _year = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.trackyBGreen,
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.m,
            FilterTitle(title: "정렬 기준",),
            Gap.s,
            ..._sortOptions.map(
              (option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _sort,
                onChanged: (value) {
                  setState(() {
                    _sort = value;
                  });
                },
              ),
            ),
            const Divider(height: 32),
            FilterTitle(title: "년",),
            Gap.s,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _yearOptions.map((year) {
                final isSelected = _year == year;
                return _buildDateFilters(isSelected, year);
              }).toList(),
            ),
            const Spacer(),
            Row(
              children: [
                _buildResetButton(),
                const SizedBox(width: 12),
                _buildApplyButton(),
              ],
            ),
            Gap.xl,
          ],
        ),
      ),
    );
  }

  GestureDetector _buildDateFilters(bool isSelected, int year) {
    return GestureDetector(
                onTap: () {
                  setState(() {
                    _year = isSelected ? null : year;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.trackyIndigo : Colors.black,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected
                        ? AppColors.trackyNeon
                        : Colors.transparent,
                  ),
                  child: Text(
                    '$year',
                    style: TextStyle(
                      color: isSelected ? AppColors.trackyIndigo : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
  }

  Expanded _buildApplyButton() {
    return Expanded(
                child: ElevatedButton(
                  onPressed: _applyFilter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD0F252),
                  ),
                  child: const Text(
                    '적용',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF021F59),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
  }

  Expanded _buildResetButton() {
    return Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilter,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text(
                    '초기화',
                    style: AppTextStyles.semiTitle,
                  ),
                ),
              );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.trackyBGreen,
      elevation: 0,
      leading: const SizedBox.shrink(),
      title: const Text('필터', style: AppTextStyles.appBarTitle),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

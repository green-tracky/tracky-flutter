import 'package:flutter/material.dart';

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
    '최신순',
    '오래된 순',
    '최장 거리',
    '최단 거리',
    '최고 페이스',
    '최저 페이스',
  ];

  final List<int> _yearOptions = [2025, 2024, 2023, 2022, 2021, 2020];

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
      backgroundColor: Color(0xFFF9FAEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FAEB),
        elevation: 0,
        leading: const SizedBox.shrink(),
        title: const Text('필터', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text('정렬 기준:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ..._sortOptions.map((option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _sort,
                  onChanged: (value) {
                    setState(() {
                      _sort = value;
                    });
                  },
                )),
            const Divider(height: 32),
            const Text('년', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _yearOptions.map((year) {
                final isSelected = _year == year;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _year = isSelected ? null : year;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: isSelected ? Color(0xFF021F59) : Colors.black, width: isSelected? 2 : 1),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Color(0xFFD0F252) : Colors.transparent,
                    ),
                    child: Text(
                      '$year',
                      style: TextStyle(
                        color: isSelected ? Color(0xFF021F59) : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetFilter,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black),
                    ),
                    child: const Text('초기화', style: TextStyle(fontSize: 16),),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD0F252),
                    ),
                    child: const Text('적용', style: TextStyle(fontSize: 16, color:Color(0xFF021F59), fontWeight: FontWeight.w700),),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

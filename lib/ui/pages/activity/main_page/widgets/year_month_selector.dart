import 'package:flutter/material.dart';

/// 아무 곳에나 배치할 수 있는 '년·월 선택' 위젯.
///   • [initialYear], [initialMonth]로 초기값 지정 가능 (기본: 오늘)
///   • 사용자가 값을 확정하면 [onChanged] 콜백으로 (year, month) 전달
class YearMonthSelector extends StatefulWidget {
  final int? initialYear;
  final int? initialMonth;
  final void Function(int year, int month)? onChanged;

  const YearMonthSelector({
    super.key,
    this.initialYear,
    this.initialMonth,
    this.onChanged,
  });

  @override
  State<YearMonthSelector> createState() => _YearMonthSelectorState();
}

class _YearMonthSelectorState extends State<YearMonthSelector> {
  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year  = widget.initialYear  ?? now.year;
    _month = widget.initialMonth ?? now.month;
  }

  @override
  Widget build(BuildContext context) {
    final label = '$_year년 $_month월';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => _openPicker(context),
            child: const Text('기간 선택'),
          ),
        ],
      ),
    );
  }

  Future<void> _openPicker(BuildContext context) async {
    final now = DateTime.now();
    int tempYear  = _year;
    int tempMonth = _month;

    final result = await showDialog<(int, int)>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('년 · 월'),
        content: StatefulBuilder(
          builder: (ctx, setState) {
            final maxMonth = (tempYear == now.year) ? now.month : 12;
            if (tempMonth > maxMonth) tempMonth = maxMonth;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ─── 년도 ───
                DropdownButton<int>(
                  value: tempYear,
                  items: List.generate(10, (i) {
                    final y = now.year - i;
                    return DropdownMenuItem(value: y, child: Text('$y년'));
                  }),
                  onChanged: (val) => setState(() {
                    tempYear = val!;
                    final max = (tempYear == now.year) ? now.month : 12;
                    if (tempMonth > max) tempMonth = max;
                  }),
                ),
                // ─── 월 ───
                DropdownButton<int>(
                  value: tempMonth,
                  items: List.generate(
                    (tempYear == now.year) ? now.month : 12,
                        (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text('${i + 1}월'),
                    ),
                  ),
                  onChanged: (val) => setState(() => tempMonth = val!),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, (tempYear, tempMonth)),
            child: const Text('확인'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        _year  = result.$1;
        _month = result.$2;
      });
      widget.onChanged?.call(_year, _month);        // 부모로 전달
    }
  }
}

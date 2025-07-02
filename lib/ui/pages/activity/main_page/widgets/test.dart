import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '년월 선택기',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _selectedYear;
  int? _selectedMonth;

  @override
  Widget build(BuildContext context) {
    final selectedText = (_selectedYear != null && _selectedMonth != null)
        ? '$_selectedYear년 $_selectedMonth월'
        : '아래의 버튼을 눌러서 날짜를 선택하세요';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedText, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => _openYearMonthPicker(context),
              child: const Text('기간 선택버튼'),
            ),
          ],
        ),
      ),
    );
  }

  /// 버튼을 눌렀을 때 호출되는 함수
  Future<void> _openYearMonthPicker(BuildContext context) async {
    // 현재 연·월을 기본값으로 사용
    final now = DateTime.now();
    int tempYear = _selectedYear ?? now.year;
    int tempMonth = _selectedMonth ?? now.month;

    // 다이얼로그 열기
    final result = await showDialog<(int year, int month)>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('년 · 월 '),
          content: StatefulBuilder(
            // 다이얼로그 내부 setState
            builder: (ctx, setState) {
              // ────── 현재 기준값 계산 ──────
              final maxMonth = (tempYear == now.year) ? now.month : 12;
              if (tempMonth > maxMonth) tempMonth = maxMonth; // 범위 보정
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ────────── 년도 드롭다운 ──────────
                  DropdownButton<int>(
                    value: tempYear,
                    items: List.generate(10, (i) {
                      // 최근 50년치
                      final y = now.year - i; // 중심을 올해로
                      return DropdownMenuItem(value: y, child: Text('$y년'));
                    }),
                    onChanged: (val) => setState(() {
                      tempYear = val!;
                      // 선택한 해가 바뀌면 월 범위도 다시 계산
                      final max = (tempYear == now.year) ? now.month : 12;
                      if (tempMonth > max) tempMonth = max;
                    }),
                  ),
                  // ────────── 월 드롭다운 ──────────
                  DropdownButton<int>(
                    value: tempMonth,
                    items: List.generate(maxMonth, (i) {
                      final m = i + 1;
                      return DropdownMenuItem(value: m, child: Text('$m월'));
                    }),
                    onChanged: (val) => setState(() => tempMonth = val!),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () => Navigator.pop(ctx),
            ),
            ElevatedButton(
              child: const Text('확인'),
              onPressed: () => Navigator.pop(ctx, (tempYear, tempMonth)),
            ),
          ],
        );
      },
    );
    // 사용자가 '확인'을 누른 경우 값이 돌아옴
    if (result != null) {
      setState(() {
        _selectedYear = result.$1;
        _selectedMonth = result.$2;
      });
      // 이곳에서 값(result.$1, result.$2)을 네트워크 요청·DB 저장 등으로 활용 가능
      debugPrint('선택된 년/월: $_selectedYear / $_selectedMonth');
    }
  }
}

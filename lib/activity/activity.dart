import 'package:flutter/material.dart';
import 'package:nike1/activity/total_record.dart';

/// Activity 섹션 – TabBar 의 선택에 따라 다른 데이터를 보여주는 위젯.
class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  late final TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // DefaultTabController 가 상위에 존재해야 함.
    _tabController = DefaultTabController.of(context)!;
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    // indexIsChanging 👉 애니메이션 완료 후에만 setState 호출
    if (!_tabController.indexIsChanging) setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int index = _tabController.index;

    // 탭 인덱스 → 기간 매핑
    final RecordRange range = switch (index) {
      0 => RecordRange.week,
      1 => RecordRange.month,
      2 => RecordRange.year,
      _ => RecordRange.all,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: TotalRecord(range: range),
      ),
    );
  }
}

/// TotalRecord 가 받을 기간 타입
enum RecordRange { week, month, year, all }

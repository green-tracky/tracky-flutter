import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/activity_vm.dart';
import 'package:tracky_flutter/ui/pages/activity/main_page/widgets/activity/total_record.dart';

/// Activity 섹션 – TabBar 의 선택에 따라 다른 데이터를 보여주는 위젯.
class Activity extends ConsumerStatefulWidget {
  const Activity({super.key});

  @override
  ConsumerState<Activity> createState() => _ActivityState();
}

class _ActivityState extends ConsumerState<Activity> {
  late final TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = DefaultTabController.of(context)!;
    _tabController.addListener(_onTabChanged);

    _loadByTabIndex(_tabController.index); // 초기 탭 인덱스 로딩
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      setState(() {}); // UI 갱신
      _loadByTabIndex(_tabController.index); // 데이터 갱신
    }
  }

  void _loadByTabIndex(int index) {
    final vm = ref.read(activityProvider.notifier);
    switch (index) {
      case 0:
        vm.loadWeek();
        break;
      case 1:
        vm.loadMonth();
        break;
      case 2:
        vm.loadYear();
        break;
      default:
        vm.loadAll();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int index = _tabController.index;

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
  enum RecordRange { week, month, year, all }

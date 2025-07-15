import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/widgets/animation_progress_bar.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/widgets/progress_explanation.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/widgets/running_level_list.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/running_level_vm.dart';

class RunningLevelPage extends ConsumerStatefulWidget {
  const RunningLevelPage({super.key});

  @override
  ConsumerState<RunningLevelPage> createState() => _RunningLevelPageState();
}

class _RunningLevelPageState extends ConsumerState<RunningLevelPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> levels = [
    {'label': '옐로우', 'range': '0 ~ 49.99킬로미터', 'color': Colors.yellow[700]},
    {'label': '오렌지', 'range': '50.00 ~ 249.9킬로미터', 'color': Colors.orange[300]},
    {'label': '그린', 'range': '250.0 ~ 999.9킬로미터', 'color': Colors.green[300]},
    {'label': '블루', 'range': '1,000 ~ 2,499킬로미터', 'color': Colors.lightBlue[300]},
    {'label': '퍼플', 'range': '2,500 ~ 4,999킬로미터', 'color': Colors.purple[200]},
    {'label': '블랙', 'range': '5,000 ~ 14,999킬로미터', 'color': Colors.black45},
    {'label': '볼트', 'range': '15,000킬로미터 ~', 'color': const Color(0xFFD0F252)},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int getCurrentLevelIndex(double km) {
    if (km < 50) return 0;
    if (km < 250) return 1;
    if (km < 1000) return 2;
    if (km < 2500) return 3;
    if (km < 5000) return 4;
    if (km < 15000) return 5;
    return 6;
  }

  double getProgressToNextLevel(double km) {
    final idx = getCurrentLevelIndex(km);
    final nextThresholds = [50, 250, 1000, 2500, 5000, 15000, 15000];
    final prevThresholds = [0, 50, 250, 1000, 2500, 5000, 15000];
    final range = nextThresholds[idx] - prevThresholds[idx];
    final progressed = km - prevThresholds[idx];
    return (progressed / range).clamp(0.0, 1.0);
  }

  double getKmToNextLevel(double km) {
    final nextThresholds = [50, 250, 1000, 2500, 5000, 15000, double.infinity];
    return (nextThresholds[getCurrentLevelIndex(km)] - km).clamp(0.0, double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    // runLevelProvider를 watch하면 AsyncValue<RunLevelResponse?> 타입을 반환합니다.
    final asyncRunLevelResponse = ref.watch(runLevelProvider);

    return asyncRunLevelResponse.when(
      data: (model) {
        // 데이터가 성공적으로 로드되었을 때의 처리
        // model이 null일 수도 있으므로 추가적인 null 체크가 필요합니다.
        if (model == null) {
          return const Center(child: Text("데이터를 불러올 수 없습니다."));
        }

        final totalKm = model.totalDistance / 1000;
        final currentLevel = getCurrentLevelIndex(totalKm);
        final remainingKm = getKmToNextLevel(totalKm);
        final targetProgress = getProgressToNextLevel(totalKm);

        _animation = Tween<double>(begin: 0, end: targetProgress).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );
        _controller.forward(from: 0);

        return Scaffold(
          appBar: _appBar(),
          backgroundColor: AppColors.trackyBGreen,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap.l,
              Icon(Icons.shield, size: 100, color: levels[currentLevel]['color']),
              Gap.s,
              AnimatedProgressBar(animation: _animation, levels: levels, currentLevel: currentLevel),
              Gap.s,
              ProgressExplanation(currentLevel: currentLevel, totalKm: totalKm, levels: levels, remainingKm: remainingKm),
              Gap.xl,
              const Divider(height: 1),
              RunningLevelList(levels: levels, currentLevel: currentLevel),
            ],
          ),
        );
      },
      loading: () {
        // 데이터 로딩 중일 때 표시할 위젯
        return const Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight), // AppBar 높이와 동일하게 설정
            child: _AppBarPlaceholder(), // 로딩 중 AppBar 대체
          ),
          backgroundColor: AppColors.trackyBGreen,
          body: Center(
            child: CircularProgressIndicator(), // 로딩 인디케이터
          ),
        );
      },
      error: (error, stackTrace) {
        // 에러 발생 시 표시할 위젯
        print("Error: $error"); // 에러 로깅
        return const Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight), // AppBar 높이와 동일하게 설정
            child: _AppBarPlaceholder(), // 에러 시 AppBar 대체
          ),
          backgroundColor: AppColors.trackyBGreen,
          body: Center(
            child: Text("데이터를 불러오는 데 실패했습니다."),
          ),
        );
      },
    );
  }

  // AppBar 로딩/에러 상태 시 보여줄 더미 AppBar (원래 AppBar와 유사하게 만듦)
  AppBar _appBar() {
    return AppBar(
      title: const Text('러닝 레벨', style: TextStyle(color: AppColors.trackyIndigo)),
      centerTitle: true,
      backgroundColor: AppColors.trackyBGreen,
      leading: const BackButton(color: Colors.black),
    );
  }
}

// AppBar 로딩/에러 시 표시할 임시 위젯 (원본 AppBar와 동일한 UI를 유지하기 위해)
class _AppBarPlaceholder extends StatelessWidget {
  const _AppBarPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('러닝 레벨', style: AppTextStyles.appBarTitle),
      centerTitle: true,
      backgroundColor: AppColors.trackyBGreen,
      leading: const BackButton(color: Colors.black),
    );
  }
}
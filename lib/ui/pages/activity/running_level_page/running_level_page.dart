import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/widgets/animation_progress_bar.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/widgets/progress_explanation.dart';
import 'package:tracky_flutter/ui/pages/activity/running_level_page/widgets/running_level_list.dart';

class RunningLevelPage extends StatefulWidget {
  const RunningLevelPage({super.key});

  @override
  State<RunningLevelPage> createState() => _RunningLevelPageState();
}

class _RunningLevelPageState extends State<RunningLevelPage> with SingleTickerProviderStateMixin {
  final double totalKm = 4500.18;
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

  int getCurrentLevelIndex() {
    if (totalKm < 50) return 0;
    if (totalKm < 250) return 1;
    if (totalKm < 1000) return 2;
    if (totalKm < 2500) return 3;
    if (totalKm < 5000) return 4;
    if (totalKm < 15000) return 5;
    return 6;
  }

  double getProgressToNextLevel() {
    final idx = getCurrentLevelIndex();
    final nextThresholds = [50, 250, 1000, 2500, 5000, 15000, 15000];
    final prevThresholds = [0, 50, 250, 1000, 2500, 5000, 15000];

    final range = nextThresholds[idx] - prevThresholds[idx];
    final progressed = totalKm - prevThresholds[idx];
    return (progressed / range).clamp(0.0, 1.0);
  }

  double getKmToNextLevel() {
    final nextThresholds = [50, 250, 1000, 2500, 5000, 15000, double.infinity];
    return (nextThresholds[getCurrentLevelIndex()] - totalKm).clamp(0.0, double.infinity);
  }

  @override
  void initState() {
    super.initState();
    final targetProgress = getProgressToNextLevel();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: targetProgress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLevel = getCurrentLevelIndex();
    final remainingKm = getKmToNextLevel();

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
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('러닝 레벨', style: TextStyle(color: AppColors.trackyIndigo)),
      centerTitle: true,
      backgroundColor: AppColors.trackyBGreen,
      leading: const BackButton(color: Colors.black),
    );
  }
}




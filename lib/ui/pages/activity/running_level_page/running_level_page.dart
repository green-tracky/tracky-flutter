import 'package:flutter/material.dart';
import 'dart:math';

class RunningLevelPage extends StatefulWidget {
  const RunningLevelPage({super.key});

  @override
  State<RunningLevelPage> createState() => _RunningLevelPageState();
}

class _RunningLevelPageState extends State<RunningLevelPage> with SingleTickerProviderStateMixin {
  final double totalKm = 122330.18;
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
      appBar: AppBar(
        title: const Text('러닝 레벨', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF9FAEB),
        leading: const BackButton(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF9FAEB),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Icon(Icons.shield, size: 100, color: levels[currentLevel]['color']),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final progress = _animation.value;
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                          color: levels[currentLevel]['color'],
                          minHeight: 8,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24 + (MediaQuery.of(context).size.width - 48) * progress - 10,
                      top: -2,
                      child: Transform.rotate(
                        angle: pi,
                        child: const Icon(
                          Icons.navigation,
                          size: 20,
                          color: Color(0xFF021F59),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: currentLevel == 6
                  ? [
                      const TextSpan(
                        text: '총 달린 거리: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextSpan(
                        text: '${totalKm.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF021F59),
                        ),
                      ),
                      const TextSpan(
                        text: ' km',
                        style: TextStyle(fontSize: 16),
                      ),
                    ]
                  : [
                      TextSpan(
                        text:
                            '${levels[(currentLevel + 1).clamp(0, levels.length - 1)]['label']} 레벨까지 ',
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextSpan(
                        text: '${remainingKm.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF021F59),
                        ),
                      ),
                      const TextSpan(
                        text: ' km 남았습니다.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final level = levels[index];
                final reached = index <= currentLevel;
                return ListTile(
                  leading: Icon(
                    Icons.shield,
                    color: reached ? level['color'] : Colors.grey[400],
                  ),
                  title: Text(
                    level['label'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: reached ? Colors.black : Colors.grey,
                    ),
                  ),
                  subtitle: Text(
                    level['range'],
                    style: TextStyle(
                      color: reached ? Colors.black54 : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

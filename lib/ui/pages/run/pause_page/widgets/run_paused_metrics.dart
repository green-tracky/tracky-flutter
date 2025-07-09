import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';

class RunPausedMetrics extends StatelessWidget {
  const RunPausedMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Metric(value: '0.00', label: '킬로미터'),
              _CenterMetric(),
              _Metric(value: '120', label: '칼로리'),
            ],
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;

  const _Metric({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        Gap.ss,
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF021F59),
          ),
        ),
      ],
    );
  }
}

class _CenterMetric extends StatelessWidget {
  const _CenterMetric();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "00:47",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        Gap.ss,
        Text(
          "시간",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF021F59),
          ),
        ),
        Gap.s,
        Text(
          "._._",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF021F59),
          ),
        ),
        Gap.s,
        Text(
          "평균 페이스",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF021F59),
          ),
        ),
      ],
    );
  }
}

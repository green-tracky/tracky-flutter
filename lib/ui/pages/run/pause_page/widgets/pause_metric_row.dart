import 'package:flutter/material.dart';

class PausedMetricRow extends StatelessWidget {
  const PausedMetricRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _MetricColumn(value: "0.00", label: "킬로미터"),
          _MetricColumn(value: "00:47", label: "시간"),
          _MetricColumn(value: "120", label: "칼로리"),
        ],
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  final String value;
  final String label;

  const _MetricColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}

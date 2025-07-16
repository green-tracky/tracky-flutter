import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:tracky_flutter/_core/constants/theme.dart';
import 'package:tracky_flutter/data/model/Run.dart';

class RunSectionRow extends StatelessWidget {
  final RunSection section;
  const RunSectionRow({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    // ▶︎ 문자열 계산
    final pace = _paceStr(section.pace); // 5'12''
    final speed = _speedStr(section.pace); // 11.5
    final varSec = _variationStr(section.variation); // -0'03''
    final varSpd = _variationSpeedStr(section.pace, section.variation);

    final diffColor = section.variation < 0 ? Colors.green : AppColors.trackyIndigo;

    // ▶︎ RotateAnimatedText 팩토리
    List<RotateAnimatedText> _rot(List<String> txts, TextStyle style) => txts
        .map(
          (t) => RotateAnimatedText(
            t,
            rotateOut: false, // 회전 IN만
            transitionHeight: 0, // 슬라이드 없애기
            textAlign: TextAlign.center,
            textStyle: style,
            duration: const Duration(milliseconds: 600),
            alignment: Alignment.center,
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // km
          Expanded(
            child: Text('${section.kilometer.toStringAsFixed(1)} km', textAlign: TextAlign.center, style: _base),
          ),
          // pace ↔ speed
          Expanded(
            child: SizedBox(
              height: 24,
              child: DefaultTextStyle(
                style: _base,
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(seconds: 5), // 5초 간격
                  animatedTexts: _rot([pace, speed], _base),
                ),
              ),
            ),
          ),
          // variation(sec ↔ km/h)
          Expanded(
            child: SizedBox(
              height: 24,
              child: DefaultTextStyle(
                style: _base.copyWith(color: diffColor),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(seconds: 5),
                  animatedTexts: _rot([varSec, varSpd], _base.copyWith(color: diffColor)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─ helpers ──────────────────────────────────────────────
  String _paceStr(String raw) {
    if (!raw.contains(':')) return raw;
    final p = raw.split(':');
    return "${p[0]}'${p[1]}''";
  }

  String _speedStr(String raw) {
    final sec = _toSec(raw);
    if (sec == null) return raw;
    return (3600 / sec).toStringAsFixed(1);
  }

  String _variationStr(int s) {
    final abs = s.abs();
    final m = (abs ~/ 60).toString();
    final ss = (abs % 60).toString().padLeft(2, '0');
    final sign = s < 0 ? '-' : '+';
    return "$sign$m'$ss''";
  }

  String _variationSpeedStr(String pace, int diffSec) {
    final base = _toSec(pace);
    if (base == null) return '';
    final sp1 = 3600 / base;
    final sp2 = 3600 / (base + diffSec);
    final delta = sp2 - sp1;
    final sign = delta < 0 ? '-' : '+';
    return "$sign${delta.abs().toStringAsFixed(1)}";
  }

  int? _toSec(String raw) {
    if (!raw.contains(':')) return null;
    final p = raw.split(':');
    return int.parse(p[0]) * 60 + int.parse(p[1]);
  }

  TextStyle get _base => const TextStyle(
    fontSize: 18,
    color: AppColors.trackyIndigo,
  );
}

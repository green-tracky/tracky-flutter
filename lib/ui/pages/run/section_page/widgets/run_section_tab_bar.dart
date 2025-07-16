import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class RunSectionTabBar extends StatelessWidget {
  const RunSectionTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 18,
      color: Colors.black54,
      fontWeight: FontWeight.w700,
    );

    List<RotateAnimatedText> _rot(List<String> txts) => txts
        .map(
          (t) => RotateAnimatedText(
            t,
            rotateOut: false,
            transitionHeight: 0,
            textAlign: TextAlign.center,
            textStyle: style,
            duration: const Duration(milliseconds: 600),
            alignment: Alignment.center,
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            child: Text('킬로미터', textAlign: TextAlign.center, style: style),
          ),
          Expanded(
            child: DefaultTextStyle(
              style: style,
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(seconds: 5),
                animatedTexts: _rot(['페이스', '속력']),
              ),
            ),
          ),
          const Expanded(
            child: Text('편차', textAlign: TextAlign.center, style: style),
          ),
        ],
      ),
    );
  }
}

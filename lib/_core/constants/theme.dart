import 'package:flutter/material.dart';

class AppColors {
  static const Color trackyBGreen = Color(0xFFF9FAEB);
  static const Color trackyIndigo = Color(0xFF021F59);
  static const Color trackyNeon = Color(0xFFD0F252);
  static const Color trackyOKBlue = Colors.blue;
  static const Color trackyCancelRed = Colors.red;
}

class AppTextStyles {
  static const TextStyle plain = TextStyle(
    fontSize: 12,
  );

  static const TextStyle content = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle semiTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle pageTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.trackyIndigo,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.trackyIndigo,
  );
}

class Gap {
  static const double ssGap = 4.0;
  static const double sGap = 12.0;
  static const double mGap = 16.0;
  static const double lGap = 20.0;
  static const double xlGap = 24.0;
  static const double xxlGap = 32.0;

  // SizedBox helpers
  static const SizedBox ss = SizedBox(height: ssGap);
  static const SizedBox s = SizedBox(height: sGap);
  static const SizedBox m = SizedBox(height: mGap);
  static const SizedBox l = SizedBox(height: lGap);
  static const SizedBox xl = SizedBox(height: xlGap);
  static const SizedBox xxl = SizedBox(height: xxlGap);
}

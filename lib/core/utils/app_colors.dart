import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xFF705C42);
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF705C42,
    <int, Color>{
      50: Color(0xFFEBE0D6),
      100: Color(0xFFD7C1AE),
      200: Color(0xFFC0A482),
      300: Color(0xFFA88756),
      400: Color(0xFF93713A),
      500: Color(0xFF705C42), // Base color
      600: Color(0xFF66533C),
      700: Color(0xFF5C4A35),
      800: Color(0xFF51402F),
      900: Color(0xFF423428),
    },
  );
  static const Color secondaryColor = Colors.white;
  static const Color textBlackColor = Color(0xFF1E201E);
  static const Color heartRedColor = Color(0xFFC22525);
  static const Color redColor = Color(0xFFB90000);
  static const Color greyColor = Color(0xFFBBBBBB);
  static const Color quranPagesColor = Color(0xffFFF9F1);
  static const Color quranPagesColor2 = Color(0xffF1EEE5);
  static const Color surahHeaderFrameColor = Color(0xffF8E5D6);
}

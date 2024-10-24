import 'package:fazakir/core/flutter_quran/lib/src/flutter_quran_screen.dart';
import 'package:flutter/material.dart';

class QuranPageView extends StatelessWidget {
  const QuranPageView(
      {super.key,
      required this.pageNumber,
      required this.shouldHighlightText,
      required this.highlightVerse});
  static const String routeName = "quranPageView";
  final int pageNumber;
  final bool shouldHighlightText;
  final String highlightVerse;
  @override
  Widget build(BuildContext context) {
    return FlutterQuranScreen(
      shouldHighlightText: shouldHighlightText,
      highlightVerse: highlightVerse,
      pageNumber: pageNumber,
    );
  }
}

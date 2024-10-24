import 'package:fazakir/core/flutter_quran/lib/src/models/quran_page.dart';
import 'package:fazakir/core/flutter_quran/lib/src/quran_pages_widget.dart';
import 'package:fazakir/core/flutter_quran/lib/src/widgets/widget_for_alfatihah_and_albaqarah.dart';
import 'package:flutter/material.dart';

class QuranScreenBody extends StatelessWidget {
  const QuranScreenBody({
    super.key,
    required this.deviceSize,
    required this.currentOrientation,
    required this.newSurahs,
    required this.index,
    required this.pages,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final Size deviceSize;
  final Orientation currentOrientation;
  final List<String> newSurahs;
  final int index;
  final List<QuranPage> pages;
  final bool shouldHighlightText;
  final String highlightVerse;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: index == 0 || index == 1

          /// This is for first 2 pages of Quran: Al-Fatihah and Al-Baqarah
          ? WidgetForAlFatihahAndAlBaqarah(
              pages: pages,
              index: index,
              deviceSize: deviceSize,
              shouldHighlightText: shouldHighlightText,
              highlightVerse: highlightVerse,
            )

          /// Other Quran pages
          : QuranPagesWidget(
              currentOrientation: currentOrientation,
              pages: pages,
              index: index,
              newSurahs: newSurahs,
              deviceSize: deviceSize,
              shouldHighlightText: shouldHighlightText,
              highlightVerse: highlightVerse),
    );
  }
}

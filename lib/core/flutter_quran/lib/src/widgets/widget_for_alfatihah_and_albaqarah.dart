import 'package:fazakir/Features/quran/presentation/widgets/surah_header_frame.dart';
import 'package:fazakir/core/flutter_quran/lib/src/controllers/bookmarks_controller.dart';
import 'package:fazakir/core/flutter_quran/lib/src/flutter_quran_screen.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/bookmark.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetForAlFatihahAndAlBaqarah extends StatelessWidget {
  const WidgetForAlFatihahAndAlBaqarah({
    super.key,
    required this.pages,
    required this.index,
    required this.deviceSize,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final List<QuranPage> pages;
  final int index;
  final Size deviceSize;
  final bool shouldHighlightText;
  final String highlightVerse;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SurahHeaderFrame(
              surahNumber: pages[index].ayahs.first.surahNumber,
            ),
            if (index == 1) const BasmallahWidget(),
            ...pages[index].lines.map((line) {
              return BlocBuilder<BookmarksCubit, List<Bookmark>>(
                builder: (context, bookmarks) {
                  final bookmarksAyahs =
                      bookmarks.map((bookmark) => bookmark.ayahId).toList();
                  return Column(
                    children: [
                      SizedBox(
                          width: deviceSize.width - 32,
                          child: QuranLine(
                            shouldHighlightText: shouldHighlightText,
                            highlightVerse: highlightVerse,
                            line,
                            bookmarksAyahs,
                            bookmarks,
                            boxFit: BoxFit.scaleDown,
                          )),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

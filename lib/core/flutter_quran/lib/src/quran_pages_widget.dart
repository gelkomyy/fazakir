import 'package:fazakir/Features/quran/presentation/widgets/surah_header_frame.dart';
import 'package:fazakir/core/flutter_quran/lib/src/controllers/bookmarks_controller.dart';
import 'package:fazakir/core/flutter_quran/lib/src/flutter_quran_screen.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/bookmark.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranPagesWidget extends StatelessWidget {
  const QuranPagesWidget({
    super.key,
    required this.currentOrientation,
    required this.pages,
    required this.index,
    required this.newSurahs,
    required this.deviceSize,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final Orientation currentOrientation;
  final List<QuranPage> pages;
  final int index;
  final List<String> newSurahs;
  final Size deviceSize;
  final bool shouldHighlightText;
  final String highlightVerse;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          physics: currentOrientation == Orientation.portrait
              ? const NeverScrollableScrollPhysics()
              : null,
          children: [
            ...pages[index].lines.map(
              (line) {
                bool firstAyah = false;
                if (line.ayahs[0].ayahNumber == 1 &&
                    !newSurahs.contains(line.ayahs[0].surahNameAr)) {
                  newSurahs.add(line.ayahs[0].surahNameAr);
                  firstAyah = true;
                }
                return BlocBuilder<BookmarksCubit, List<Bookmark>>(
                  builder: (context, bookmarks) {
                    final bookmarksAyahs =
                        bookmarks.map((bookmark) => bookmark.ayahId).toList();
                    return Column(
                      children: [
                        if (firstAyah)
                          SurahHeaderFrame(
                            surahNumber: line.ayahs.first.surahNumber,
                          ),
                        if (firstAyah && (line.ayahs[0].surahNumber != 9))
                          const BasmallahWidget(),
                        SizedBox(
                          width: deviceSize.width - 30,
                          height: ((currentOrientation == Orientation.portrait
                                      ? constraints.maxHeight
                                      : deviceSize.width) -
                                  (pages[index].numberOfNewSurahs *
                                      (line.ayahs[0].surahNumber != 9
                                          ? 135
                                          : 80))) *
                              0.97 /
                              pages[index].lines.length,
                          child: QuranLine(
                            shouldHighlightText: shouldHighlightText,
                            highlightVerse: highlightVerse,
                            line,
                            bookmarksAyahs,
                            bookmarks,
                            boxFit: line.ayahs.last.centered
                                ? BoxFit.scaleDown
                                : BoxFit.fill,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

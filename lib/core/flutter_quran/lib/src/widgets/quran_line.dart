part of '../flutter_quran_screen.dart';

class QuranLine extends StatefulWidget {
  const QuranLine(
    this.line,
    this.bookmarksAyahs,
    this.bookmarks, {
    super.key,
    this.boxFit = BoxFit.fill,
    this.onLongPress,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final Line line;
  final List<int> bookmarksAyahs;
  final List<Bookmark> bookmarks;
  final BoxFit boxFit;
  final Function? onLongPress;
  final bool shouldHighlightText;
  final String highlightVerse;

  @override
  State<QuranLine> createState() => _QuranLineState();
}

class _QuranLineState extends State<QuranLine> {
  String highlightVerse = "";
  bool shouldHighlightText = false;
  Timer? timer;
  String selectedSpan = "";
  highlightVerseFunction() {
    if (shouldHighlightText) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            shouldHighlightText = false;
          });
        }
        Timer(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              shouldHighlightText = true;
            });
          }
          if (timer.tick == 1) {
            if (mounted) {
              setState(() {
                highlightVerse = "";

                shouldHighlightText = false;
              });
            }
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  void initState() {
    shouldHighlightText = widget.shouldHighlightText;
    highlightVerse = widget.highlightVerse;
    highlightVerseFunction();

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: widget.boxFit,
      child: RichText(
        text: TextSpan(
          children: widget.line.ayahs.reversed.map((ayah) {
            return WidgetSpan(
              child: GestureDetector(
                onLongPressDown: (details) => setState(() {
                  selectedSpan = '${ayah.surahNumber} ${ayah.ayahNumber}';
                }),
                onLongPressUp: () => setState(() {
                  selectedSpan = "";
                }),
                onLongPressCancel: () => setState(() {
                  selectedSpan = "";
                }),
                onLongPress: () {
                  Clipboard.setData(
                    ClipboardData(
                        text:
                            '${getVerse(ayah.surahNumber, ayah.ayahNumber, verseEndSymbol: true)} \n [${getSurahNameArabic(ayah.surahNumber)} : ${ayah.ayahNumber.toArabicDigits()}]'),
                  ).then(
                    (_) {
                      if (!context.mounted) return;
                      showCustomSnackBar(
                          context,
                          ' تم نسخ الايه رقم ${ayah.ayahNumber.toArabicDigits()} '
                          'كاملة');

                      selectedSpan = "";
                    },
                  );
                  /*      if (widget.onLongPress != null) {
                    widget.onLongPress!(ayah);
                  } else {
                    final bookmarkId = widget.bookmarksAyahs.contains(ayah.id)
                        ? widget
                            .bookmarks[widget.bookmarksAyahs.indexOf(ayah.id)]
                            .id
                        : null;
                    if (bookmarkId != null) {
                      AppBloc.bookmarksCubit.removeBookmark(bookmarkId);
                    } else {
                      showDialog(
                          context: context,
                          builder: (ctx) => AyahLongClickDialog(ayah));
                    }
                  } */
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: shouldHighlightText
                        ? getVerse(ayah.surahNumber, ayah.ayahNumber,
                                    verseEndSymbol: true) ==
                                widget.highlightVerse
                            ? AppColors.surahHeaderFrameColor
                            : selectedSpan ==
                                    '${ayah.surahNumber} ${ayah.ayahNumber}'
                                ? AppColors.quranPagesColor2
                                : null
                        : selectedSpan ==
                                '${ayah.surahNumber} ${ayah.ayahNumber}'
                            ? AppColors.quranPagesColor2
                            : null,
                    /*  color: widget.bookmarksAyahs.contains(ayah.id)
                        ? Color(widget.bookmarks[widget.bookmarksAyahs.indexOf(ayah.id)]
                                .colorCode)
                            .withOpacity(0.7)
                        : null, */
                  ),
                  child: Text(
                    //textAlign: TextAlign.justify,
                    ayah.ayah,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getTheFontSize(context, fontSize: 23.55),
                      fontFamily: "uthmanic_hafs",
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          style: TextStyle(
            color: Colors.black,
            fontSize: getTheFontSize(context, fontSize: 23.55),
            fontFamily: "uthmanic_hafs",
          ),
        ),
      ),
    );
  }
}

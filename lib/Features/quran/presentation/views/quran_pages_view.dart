import 'dart:async';
import 'dart:developer';

import 'package:fazakir/Features/quran/presentation/widgets/basmala.dart';
import 'package:fazakir/Features/quran/presentation/widgets/surah_header_frame.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class QuranPagesView extends StatefulWidget {
  const QuranPagesView(
      {super.key,
      required this.pageNumber,
      this.shouldHighlightText = false,
      this.highlightVerse = ''});
  static const String routeName = 'quranPagesView';
  final int pageNumber;
  final bool shouldHighlightText;
  final String highlightVerse;
  @override
  State<QuranPagesView> createState() => _QuranPagesViewState();
}

class _QuranPagesViewState extends State<QuranPagesView> {
  String highlightVerse = "";
  bool shouldHighlightText = false;
  int pageNumber = 1;
  List<GlobalKey> richTextKeys = List.generate(
    604, // Replace with the number of pages in your PageView
    (_) => GlobalKey(),
  );
  late PageController _pageController;
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
    pageNumber = widget.pageNumber;
    shouldHighlightText = widget.shouldHighlightText;
    highlightVerse = widget.highlightVerse;
    _pageController = PageController(initialPage: pageNumber);
    highlightVerseFunction();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WakelockPlus.enable();

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.quranPagesColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          onPageChanged: (a) {
            setState(() {
              selectedSpan = "";
            });
            pageNumber = a;
            log(pageNumber.toString());
          },
          controller: _pageController,
          // onPageChanged: _onPageChanged,
          itemCount:
              totalPagesCount + 1 /* specify the total number of pages */,
          itemBuilder: (context, index) {
            //bool isEvenPage = index.isEven;

            if (index == 0) {
              return Container(
                color: AppColors.primaryColor,
                child: Image.asset(
                  Assets.assetsImagesQuran,
                  fit: BoxFit.fill,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12),
              child: SingleChildScrollView(
                // physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الجزء ${getJuzNumber(getPageData(index)[0]["surah"], getPageData(index)[0]["start"]).toArabicDigits()}',
                          style: AppFontStyles.styleRegular18(context).copyWith(
                            fontFamily: "Scheherazade",
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            style: AppFontStyles.styleRegular28(context)
                                .copyWith(
                                    fontFamily: "arsura",
                                    color: AppColors.primaryColor),
                            children: getPageData(index)
                                .map(
                                  (e) => TextSpan(
                                    text: '${e["surah"]} ',
                                    style: AppFontStyles.styleRegular28(context)
                                        .copyWith(
                                            fontFamily: "arsura",
                                            color: AppColors.primaryColor),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    if ((index == 1 || index == 2))
                      SizedBox(
                        height: (screenSize.height * .15),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: RichText(
                            key: richTextKeys[index - 1],
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            locale: const Locale("ar"),
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 23.5,
                              ),
                              children: getPageData(index).expand(
                                (e) {
                                  List<InlineSpan> spans = [];
                                  for (int i = e["start"]; i <= e["end"]; i++) {
                                    // Header
                                    if (i == 1) {
                                      spans.add(WidgetSpan(
                                        child: SurahHeaderFrame(
                                            surahNumber: e["surah"]),
                                      ));
                                      if (index != 187 && index != 1) {
                                        spans.add(const WidgetSpan(
                                          child: Basmala(),
                                        ));
                                      }
                                      if (index == 187) {
                                        spans.add(
                                          WidgetSpan(
                                            child: Container(
                                              height: 6,
                                            ),
                                          ),
                                        );
                                      }
                                    }

                                    // Verses
                                    spans.add(
                                      TextSpan(
                                        recognizer: LongPressGestureRecognizer()
                                          ..onLongPress = () {
                                            // showAyahOptionsSheet(
                                            //     index,
                                            //     e["surah"],
                                            //     i);
                                            log("longPressed Hereeeee..");
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      '${getVerse(e["surah"], i, verseEndSymbol: true)} \n [${getSurahNameArabic(e["surah"])} : ${i.toArabicDigits()}]'),
                                            ).then(
                                              (_) {
                                                if (!context.mounted) return;
                                                showCustomSnackBar(
                                                    context, 'تم النسخ');
                                                setState(() {
                                                  selectedSpan = "";
                                                });
                                              },
                                            );
                                          }
                                          ..onLongPressDown = (details) {
                                            setState(() {
                                              selectedSpan = " ${e["surah"]}$i";
                                            });
                                          }
                                          ..onLongPressUp = () {
                                            setState(() {
                                              selectedSpan = "";
                                            });
                                            log("Finished long press");
                                          }
                                          ..onLongPressCancel =
                                              () => setState(() {
                                                    selectedSpan = "";
                                                  }),
                                        text: i == e["start"]
                                            ? "${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1) /* .replaceAll(getVerseQCF(e["surah"], i).substring(getVerseQCF(e["surah"], i).length - 1), '') */}"
                                            : getVerseQCF(e["surah"], i)
                                                .replaceAll(' ', '')
                                        /*  .replaceAll(
                                                    getVerseQCF(e["surah"], i)
                                                        .substring(getVerseQCF(
                                                                    e["surah"],
                                                                    i)
                                                                .length -
                                                            1),
                                                    '') */
                                        ,
                                        //  i == e["start"]
                                        // ? "${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1).substring(0,  getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1).length - 1)}"
                                        // :
                                        // getVerseQCF(e["surah"], i).replaceAll(' ', '').substring(0,  getVerseQCF(e["surah"], i).replaceAll(' ', '').length - 1),
                                        style: TextStyle(
                                          color: Colors.black,
                                          height: getTheFontSize(context,
                                              fontSize: 2.13),
                                          letterSpacing: getTheFontSize(context,
                                              fontSize: 0.4),
                                          wordSpacing: 0,
                                          fontFamily:
                                              "QCF_P${index.toString().padLeft(3, "0")}",
                                          /*  fontSize: index == 1 || index == 2
                                              ? 28
                                              : index == 145 || index == 201
                                                  ? index == 532 || index == 533
                                                      ? 22.5
                                                      : 22.4
                                                  : 23, */
                                          fontSize: index == 1 || index == 2
                                              ? getTheFontSize(context,
                                                  fontSize: 28)
                                              : index == 145 || index == 201
                                                  ? index == 532 || index == 533
                                                      ? getTheFontSize(context,
                                                          fontSize: 22.5)
                                                      : getTheFontSize(context,
                                                          fontSize: 22.4)
                                                  : getTheFontSize(context,
                                                      fontSize: 22.65),
                                          backgroundColor: shouldHighlightText
                                              ? getVerse(e["surah"], i,
                                                          verseEndSymbol:
                                                              true) ==
                                                      widget.highlightVerse
                                                  ? AppColors
                                                      .surahHeaderFrameColor
                                                  : selectedSpan ==
                                                          " ${e["surah"]}$i"
                                                      ? AppColors
                                                          .surahHeaderFrameColor
                                                      : Colors.transparent
                                              : selectedSpan ==
                                                      " ${e["surah"]}$i"
                                                  ? AppColors
                                                      .surahHeaderFrameColor
                                                  : Colors.transparent,
                                        ),
                                        children: const [
                                          /* WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: 17,
                                                      height: 17,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: AppColors
                                                            .surahHeaderFrameColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Image.asset(
                                                      Assets
                                                          .assetsImagesAyahEndSymbol,
                                                      width: 24,
                                                      height: 24,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 1.5,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        i.toArabicDigits(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppFontStyles
                                                                .styleRegular11(
                                                                    context)
                                                            .copyWith(
                                                          fontFamily:
                                                              "Scheherazade",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ), */
                                          /* TextSpan(
                                            text: getVerseQCF(e["surah"], i)
                                                .substring(
                                                    getVerseQCF(e["surah"], i)
                                                            .length -
                                                        1),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ), */
                                        ],
                                      ),
                                    );
                                  }
                                  return spans;
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 62,
                      margin: const EdgeInsets.only(
                        top: 12,
                      ),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.surahHeaderFrameColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          index.toArabicDigits(),
                          style: const TextStyle(
                            fontFamily: 'aldahabi',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:fazakir/Features/quran/presentation/widgets/basmala.dart';
import 'package:fazakir/Features/quran/presentation/widgets/surah_header_frame.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart';
import 'package:easy_container/easy_container.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class QuranPagesView extends StatefulWidget {
  const QuranPagesView({super.key});
  static const String routeName = 'quranPagesView';
  @override
  State<QuranPagesView> createState() => _QuranPagesViewState();
}

class _QuranPagesViewState extends State<QuranPagesView> {
  String highlightVerse = "";
  bool shouldHighlightText = false;
  int pageNumber = 187;
  List<GlobalKey> richTextKeys = List.generate(
    604, // Replace with the number of pages in your PageView
    (_) => GlobalKey(),
  );
  late PageController _pageController;
  Timer? timer;
  String selectedSpan = "";

  highlightVerseFunction() {
    if (shouldHighlightText) {
      Timer.periodic(const Duration(milliseconds: 400), (timer) {
        if (mounted) {
          setState(() {
            shouldHighlightText = false;
          });
        }
        Timer(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              shouldHighlightText = true;
            });
          }
          if (timer.tick == 4) {
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
      body: PageView.builder(
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
        itemCount: totalPagesCount + 1 /* specify the total number of pages */,
        itemBuilder: (context, index) {
          //bool isEvenPage = index.isEven;

          if (index == 0) {
            return Container(
              color: const Color(0xffFFFCE7),
              child: Image.asset(
                "assets/images/jpg",
                fit: BoxFit.fill,
              ),
            );
          }

          return Container(
            decoration: const BoxDecoration(
              color: AppColors.quranPagesColor,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12),
                  child: SingleChildScrollView(
                    // physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenSize.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (screenSize.width * .27),
                                child: const Row(
                                  children: [
                                    Text('Surah Name..',
                                        style: TextStyle(
                                            fontFamily: "Taha", fontSize: 14)),
                                  ],
                                ),
                              ),
                              EasyContainer(
                                borderRadius: 12,
                                color: Colors.orange.withOpacity(.5),
                                showBorder: true,
                                height: 20,
                                width: 120,
                                padding: 0,
                                margin: 0,
                                child: Center(
                                  child: Text(
                                    "${"page"} $index ",
                                    style: const TextStyle(
                                      fontFamily: 'aldahabi',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: (screenSize.width * .27),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.settings,
                                          size: 24,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
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
                                      for (int i = e["start"];
                                          i <= e["end"];
                                          i++) {
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
                                            recognizer:
                                                LongPressGestureRecognizer()
                                                  ..onLongPress = () {
                                                    // showAyahOptionsSheet(
                                                    //     index,
                                                    //     e["surah"],
                                                    //     i);
                                                    log("longPressed Hereeeee..");
                                                  }
                                                  ..onLongPressDown =
                                                      (details) {
                                                    setState(() {
                                                      selectedSpan =
                                                          " ${e["surah"]}$i";
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
                                                ? "${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1)}"
                                                : getVerseQCF(e["surah"], i)
                                                    .replaceAll(' ', ''),
                                            //  i == e["start"]
                                            // ? "${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1).substring(0,  getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1).length - 1)}"
                                            // :
                                            // getVerseQCF(e["surah"], i).replaceAll(' ', '').substring(0,  getVerseQCF(e["surah"], i).replaceAll(' ', '').length - 1),
                                            style: TextStyle(
                                              color: Colors.black,
                                              height: 2,
                                              letterSpacing: 0.5,
                                              wordSpacing: 0,
                                              fontFamily:
                                                  "QCF_P${index.toString().padLeft(3, "0")}",
                                              fontSize: index == 1 || index == 2
                                                  ? 28
                                                  : index == 145 || index == 201
                                                      ? index == 532 ||
                                                              index == 533
                                                          ? 22.5
                                                          : 22.4
                                                      : 23.5,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            children: const <TextSpan>[
                                              /*     TextSpan(
                                                text: getVerseQCF(e["surah"], i)
                                                    .substring(getVerseQCF(
                                                                e["surah"], i)
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

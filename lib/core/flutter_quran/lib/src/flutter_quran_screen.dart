import 'dart:async';

import 'package:fazakir/Features/quran/presentation/widgets/surah_header_frame.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/ayah.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/bookmark.dart';
import 'package:fazakir/core/flutter_quran/lib/src/utils/flutter_quran_utils.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran/quran.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'app_bloc.dart';
import 'controllers/bookmarks_controller.dart';
import 'controllers/quran_controller.dart';
import 'models/quran_page.dart';
part 'utils/images.dart';
part 'utils/toast_utils.dart';
part 'widgets/bsmallah_widget.dart';
part 'widgets/quran_line.dart';
part 'widgets/default_drawer.dart';
part 'widgets/ayah_long_click_dialog.dart';

class FlutterQuranScreen extends StatefulWidget {
  const FlutterQuranScreen({
    super.key,
    this.onPageChanged,
    required this.pageNumber,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final int pageNumber;

  ///[onPageChanged] if provided it will be called when a quran page changed
  final Function(int)? onPageChanged;

  final bool shouldHighlightText;
  final String highlightVerse;

  @override
  State<FlutterQuranScreen> createState() => _FlutterQuranScreenState();
}

class _FlutterQuranScreenState extends State<FlutterQuranScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WakelockPlus.enable();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => AppBloc.quranCubit.animateToPage(widget.pageNumber - 1));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final Orientation currentOrientation = MediaQuery.orientationOf(context);
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xffFFF9F1),
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<QuranCubit, List<QuranPage>>(
            builder: (ctx, pages) {
              return pages.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF705C42)),
                      ),
                    )
                  : SafeArea(
                      child: PageView.builder(
                        itemCount: pages.length,
                        controller: AppBloc.quranCubit.pageController,
                        onPageChanged: (page) {
                          if (widget.onPageChanged != null) {
                            widget.onPageChanged!(page + 1);
                          }

                          AppBloc.quranCubit.saveLastPage(page + 1);
                        },
                        pageSnapping: true,
                        itemBuilder: (ctx, index) {
                          List<String> newSurahs = [];
                          return Container(
                            height: deviceSize.height * 0.8,
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                HeaderOfQuranScreen(
                                  pageNumber: pages[index].pageNumber,
                                ),
                                QuranScreenBody(
                                  shouldHighlightText:
                                      widget.shouldHighlightText,
                                  highlightVerse: widget.highlightVerse,
                                  pages: pages,
                                  deviceSize: deviceSize,
                                  currentOrientation: currentOrientation,
                                  newSurahs: newSurahs,
                                  index: index,
                                ),
                                PageNumberOfQuranWidget(
                                  pageNumber: pages[index].pageNumber,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

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
          ? Center(
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
                          final bookmarksAyahs = bookmarks
                              .map((bookmark) => bookmark.ayahId)
                              .toList();
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
            )

          /// Other Quran pages
          : LayoutBuilder(
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
                            final bookmarksAyahs = bookmarks
                                .map((bookmark) => bookmark.ayahId)
                                .toList();
                            return Column(
                              children: [
                                if (firstAyah)
                                  SurahHeaderFrame(
                                    surahNumber: line.ayahs.first.surahNumber,
                                  ),
                                if (firstAyah &&
                                    (line.ayahs[0].surahNumber != 9))
                                  const BasmallahWidget(),
                                SizedBox(
                                  width: deviceSize.width - 30,
                                  height: ((currentOrientation ==
                                                  Orientation.portrait
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
            ),
    );
  }
}

class PageNumberOfQuranWidget extends StatelessWidget {
  const PageNumberOfQuranWidget({
    super.key,
    required this.pageNumber,
  });
  final int pageNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
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
          pageNumber.toArabicDigits(),
          style: const TextStyle(
            fontFamily: "Scheherazade",
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class HeaderOfQuranScreen extends StatelessWidget {
  const HeaderOfQuranScreen({
    super.key,
    required this.pageNumber,
  });
  final int pageNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'الجزء ${getJuzNumber(getPageData(pageNumber)[0]["surah"], getPageData(pageNumber)[0]["start"]).toArabicDigits()}',
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
                .copyWith(fontFamily: "arsura", color: AppColors.primaryColor),
            children: getPageData(pageNumber)
                .map(
                  (e) => TextSpan(
                    text: '${e["surah"]} ',
                    style: AppFontStyles.styleRegular28(context).copyWith(
                        fontFamily: "arsura", color: AppColors.primaryColor),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _FlutterQuranSearchScreen extends StatefulWidget {
  const _FlutterQuranSearchScreen();

  @override
  State<_FlutterQuranSearchScreen> createState() =>
      _FlutterQuranSearchScreenState();
}

class _FlutterQuranSearchScreenState extends State<_FlutterQuranSearchScreen> {
  List<Ayah> ayahs = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('بحث'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  onChanged: (txt) {
                    final searchResult = FlutterQuran().search(txt);
                    setState(() {
                      ayahs = [...searchResult];
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'بحث',
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: ayahs
                        .map((ayah) => Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    ayah.ayah.replaceAll('\n', ' '),
                                  ),
                                  subtitle: Text(ayah.surahNameAr),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    FlutterQuran().navigateToAyah(ayah);
                                  },
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

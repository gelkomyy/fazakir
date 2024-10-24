/* import 'dart:developer';

import 'package:fazakir/Features/quran/data/models/ayah_model.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class QuranPageView extends StatefulWidget {
  static const String routeName = "quranPageView";

  const QuranPageView({super.key});

  @override
  State<QuranPageView> createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  final List<Map<String, dynamic>> quranPageData = [
    {
      "id": 13,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 1,
      "line_end": 2,
      "aya_no": 6,
      "aya_text":
          " إِنَّ ٱلَّذِينَ كَفَرُواْ سَوَآءٌ عَلَيۡهِمۡ ءَأَنذَرۡتَهُمۡ أَمۡ لَمۡ تُنذِرۡهُمۡ لَا يُؤۡمِنُونَ ﰅ",
      "aya_text_emlaey":
          "إن الذين كفروا سواء عليهم أأنذرتهم أم لم تنذرهم لا يؤمنون"
    },
    {
      "id": 14,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 2,
      "line_end": 3,
      "aya_no": 7,
      "aya_text":
          "خَتَمَ ٱللَّهُ عَلَىٰ قُلُوبِهِمۡ وَعَلَىٰ سَمۡعِهِمۡۖ وَعَلَىٰٓ أَبۡصَٰرِهِمۡ غِشَٰوَةٞۖ وَلَهُمۡ عَذَابٌ عَظِيمٞ ﰆ",
      "aya_text_emlaey":
          "ختم الله على قلوبهم وعلى سمعهم وعلى أبصارهم غشاوة ولهم عذاب عظيم"
    },
    {
      "id": 15,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 3,
      "line_end": 4,
      "aya_no": 8,
      "aya_text":
          "وَمِنَ ٱلنَّاسِ مَن يَقُولُ ءَامَنَّا بِٱللَّهِ وَبِٱلۡيَوۡمِ ٱلۡأٓخِرِ وَمَا هُم بِمُؤۡمِنِينَ ﰇ",
      "aya_text_emlaey":
          "ومن الناس من يقول آمنا بالله وباليوم الآخر وما هم بمؤمنين"
    },
    {
      "id": 16,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 5,
      "line_end": 6,
      "aya_no": 9,
      "aya_text":
          "يُخَٰدِعُونَ ٱللَّهَ وَٱلَّذِينَ ءَامَنُواْ وَمَا يَخۡدَعُونَ إِلَّآ أَنفُسَهُمۡ وَمَا يَشۡعُرُونَ ﰈ",
      "aya_text_emlaey":
          "يخادعون الله والذين آمنوا وما يخدعون إلا أنفسهم وما يشعرون"
    },
    {
      "id": 17,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 6,
      "line_end": 7,
      "aya_no": 10,
      "aya_text":
          "فِي قُلُوبِهِم مَّرَضٞ فَزَادَهُمُ ٱللَّهُ مَرَضٗاۖ وَلَهُمۡ عَذَابٌ أَلِيمُۢ بِمَا كَانُواْ يَكۡذِبُونَ ﰉ",
      "aya_text_emlaey":
          "في قلوبهم مرض فزادهم الله مرضا ولهم عذاب أليم بما كانوا يكذبون"
    },
    {
      "id": 18,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 7,
      "line_end": 8,
      "aya_no": 11,
      "aya_text":
          "وَإِذَا قِيلَ لَهُمۡ لَا تُفۡسِدُواْ فِي ٱلۡأَرۡضِ قَالُوٓاْ إِنَّمَا نَحۡنُ مُصۡلِحُونَ ﰊ",
      "aya_text_emlaey": "وإذا قيل لهم لا تفسدوا في الأرض قالوا إنما نحن مصلحون"
    },
    {
      "id": 19,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 8,
      "line_end": 9,
      "aya_no": 12,
      "aya_text":
          "أَلَآ إِنَّهُمۡ هُمُ ٱلۡمُفۡسِدُونَ وَلَٰكِن لَّا يَشۡعُرُونَ ﰋ",
      "aya_text_emlaey": "ألا إنهم هم المفسدون ولكن لا يشعرون"
    },
    {
      "id": 20,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 9,
      "line_end": 11,
      "aya_no": 13,
      "aya_text":
          "وَإِذَا قِيلَ لَهُمۡ ءَامِنُواْ كَمَآ ءَامَنَ ٱلنَّاسُ قَالُوٓاْ أَنُؤۡمِنُ كَمَآ ءَامَنَ ٱلسُّفَهَآءُۗ أَلَآ إِنَّهُمۡ هُمُ ٱلسُّفَهَآءُ وَلَٰكِن لَّا يَعۡلَمُونَ ﰌ",
      "aya_text_emlaey":
          "وإذا قيل لهم آمنوا كما آمن الناس قالوا أنؤمن كما آمن السفهاء ألا إنهم هم السفهاء ولكن لا يعلمون"
    },
    {
      "id": 21,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 11,
      "line_end": 13,
      "aya_no": 14,
      "aya_text":
          "وَإِذَا لَقُواْ ٱلَّذِينَ ءَامَنُواْ قَالُوٓاْ ءَامَنَّا وَإِذَا خَلَوۡاْ إِلَىٰ شَيَٰطِينِهِمۡ قَالُوٓاْ إِنَّا مَعَكُمۡ إِنَّمَا نَحۡنُ مُسۡتَهۡزِءُونَ ﰍ",
      "aya_text_emlaey":
          "وإذا لقوا الذين آمنوا قالوا آمنا وإذا خلوا إلى شياطينهم قالوا إنا معكم إنما نحن مستهزئون"
    },
    {
      "id": 22,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 13,
      "line_end": 14,
      "aya_no": 15,
      "aya_text":
          "ٱللَّهُ يَسۡتَهۡزِئُ بِهِمۡ وَيَمُدُّهُمۡ فِي طُغۡيَٰنِهِمۡ يَعۡمَهُونَ ﰎ",
      "aya_text_emlaey": "الله يستهزئ بهم ويمدهم في طغيانهم يعمهون"
    },
    {
      "id": 23,
      "jozz": 1,
      "page": 3,
      "sura_no": 2,
      "sura_name_en": "Al-Baqarah",
      "sura_name_ar": "البَقَرَة",
      "line_start": 14,
      "line_end": 15,
      "aya_no": 16,
      "aya_text":
          "أُوْلَٰٓئِكَ ٱلَّذِينَ ٱشۡتَرَوُاْ ٱلضَّلَٰلَةَ بِٱلۡهُدَىٰ فَمَا رَبِحَت تِّجَٰرَتُهُمۡ وَمَا كَانُواْ مُهۡتَدِينَ ﰏ",
      "aya_text_emlaey":
          "أولئك الذين اشتروا الضلالة بالهدى فما ربحت تجارتهم وما كانوا مهتدين"
    },
  ];

  final int totalLinesPerPage = 15;
  late PageController _pageController;
  int pageNumber = 1;
  @override
  void initState() {
    _pageController = PageController(initialPage: pageNumber);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    WakelockPlus.enable();

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quranPagesColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (pageIndex) {
            log(pageIndex.toString());
            setState(() {
              pageNumber = pageIndex;
            });
          },
          itemCount: 1 + 1, // Assuming we're only displaying one page here
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                  color: AppColors.primaryColor,
                  child: Image.asset(
                    Assets.assetsImagesQuran,
                    fit: BoxFit.fill,
                  ));
            }
            return buildQuranPage(
                context, AyahModel.listOfMapsToListOfAyahModel(quranPageData));
          },
        ),
      ),
    );
  }

  Widget buildQuranPage(BuildContext context, List<AyahModel> data) {
    // Create a list to hold the lines
    List<Widget> pageLines = List.generate(totalLinesPerPage, (index) {
      return buildEmptyLine(); // Initialize all lines as empty
    });

    for (var i = 0; i < data.length; i++) {
      var currentAyah = data[i];
      int lineStart = currentAyah.lineStart - 1; // Convert to zero index
      int lineEnd = currentAyah.lineEnd - 1;

      // Check if the next Ayah starts on the same line
      if (i < data.length - 1 && data[i + 1].lineStart == currentAyah.lineEnd) {
        // Merge the next Ayah's text with the current one
        String mergedText = "${currentAyah.ayaText} ${data[i + 1].ayaText}";
        // Place merged text in the starting line
        pageLines[lineStart] = buildAyaLine(mergedText);
        i++; // Skip the next Ayah since it has been merged
      } else {
        // Place the Ayah normally in its respective lines
        for (int j = lineStart; j <= lineEnd; j++) {
          if (j == lineStart) {
            // Set the first line for this Ayah
            pageLines[j] = buildAyaLine(currentAyah.ayaText);
          } else {
            // Ensure remaining lines are marked as empty
            pageLines[j] = buildEmptyLine();
          }
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الجزء ${getJuzNumber(getPageData(pageNumber)[0]["surah"], getPageData(pageNumber)[0]["start"]).toArabicDigits()}',
                  style: AppFontStyles.styleRegular18(context).copyWith(
                    fontFamily: "Scheherazade",
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 20),
                RichText(
                  text: TextSpan(
                    style: AppFontStyles.styleRegular28(context).copyWith(
                        fontFamily: "arsura", color: AppColors.primaryColor),
                    children: getPageData(pageNumber)
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
            ...pageLines
          ],
        ),
      ),
    );
  }

  Widget buildAyaLine(String text, {bool append = false}) {
    return Align(
      alignment: Alignment.centerRight, // Align text to the right for Arabic
      child: RichText(
        textDirection: TextDirection.rtl, // Set text direction for Arabic
        textAlign: TextAlign.justify,
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 23.55,
            fontFamily: 'uthmanic_hafs', // Ensure you have this font in assets
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyLine() {
    return const SizedBox(
      height: 20, // Adjust height for empty lines
    );
  }
}














////////////////////////////
///




 */

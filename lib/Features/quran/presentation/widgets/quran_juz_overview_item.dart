import 'package:fazakir/Features/quran/presentation/views/quran_pages_view.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class QuranJuzOverviewItem extends StatelessWidget {
  const QuranJuzOverviewItem({
    super.key,
    required this.juzNumber,
  });

  final num juzNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      visualDensity: const VisualDensity(
        horizontal: -4,
        vertical: -4,
      ),
      tileColor: const Color(0x51BBBBBB),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      title: Text(
        juzNumber.toQuranJuz(),
        style: AppFontStyles.styleBold20(context).copyWith(
          fontFamily: 'Scheherazade',
        ),
      ),
      subtitle: Text(
        getVerse(getSurahAndVersesFromJuz(juzNumber.toInt()).keys.first, 1,
            verseEndSymbol: true),
        style: AppFontStyles.styleRegular18(context).copyWith(
          color: AppColors.primaryColor,
          fontFamily: 'Amiri',
          height: 2.2,
        ),
      ),
      trailing: RichText(
        text: TextSpan(
          text:
              getSurahAndVersesFromJuz(juzNumber.toInt()).keys.first.toString(),
          style: AppFontStyles.styleRegular28(context)
              .copyWith(fontFamily: "arsura", color: AppColors.primaryColor),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          QuranPagesView.routeName,
          arguments: {
            'highlightVerse': '',
            'shouldHighlightText': false,
            'pageNumber': getPageNumber(
                getSurahAndVersesFromJuz(juzNumber.toInt()).keys.first, 1),
          },
        );
      },
    );
  }
}

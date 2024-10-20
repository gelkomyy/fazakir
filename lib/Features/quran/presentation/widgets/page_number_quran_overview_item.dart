import 'package:fazakir/Features/quran/presentation/views/quran_pages_view.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class PageNumberQuranOverviewItem extends StatelessWidget {
  const PageNumberQuranOverviewItem({
    super.key,
    required this.queryNum,
  });

  final num queryNum;

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
      tileColor:  AppColors.greyColor2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      title: Text(
        "الصفحة ${queryNum.toArabicDigits()}",
        style: AppFontStyles.styleBold20(context).copyWith(
          fontFamily: 'Scheherazade',
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
          style: AppFontStyles.styleRegular28(context)
              .copyWith(fontFamily: "arsura", color: AppColors.primaryColor),
          children: getPageData(queryNum.toInt())
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
      trailing: const Icon(
        Icons.arrow_forward_outlined,
        color: AppColors.greyColor,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          QuranPagesView.routeName,
          arguments: {
            'highlightVerse': '',
            'shouldHighlightText': false,
            'pageNumber': queryNum,
          },
        );
      },
    );
  }
}

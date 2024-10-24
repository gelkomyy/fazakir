import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

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

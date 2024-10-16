import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/Features/quran/presentation/views/quran_pages_view.dart';
import 'package:fazakir/core/enums/revelation_type_enum.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class SurahOverviewItem extends StatelessWidget {
  const SurahOverviewItem({
    super.key,
    required this.surahEntity,
  });

  final SurahEntity surahEntity;

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
      title: RichText(
        text: TextSpan(
          text: surahEntity.number.toString(),
          style: AppFontStyles.styleRegular28(context)
              .copyWith(fontFamily: "arsura", color: AppColors.primaryColor),
        ),
      ),
      subtitle: Text(
        '${surahEntity.revelationType.arabicName} - '
        'عدد آياتها ${surahEntity.numberOfAyahs.toArabicDigits()}',
        style: AppFontStyles.styleBold15(context).copyWith(
          color: AppColors.greyColor,
          fontFamily: 'Scheherazade',
        ),
      ),
      leading: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: getResponsiveFontSize(context, fontSize: 30),
            height: getResponsiveFontSize(context, fontSize: 30),
            color: const Color(0xBF705C42),
          ),
          Container(
            width: getResponsiveFontSize(context, fontSize: 44),
            height: getResponsiveFontSize(context, fontSize: 44),
            decoration: const ShapeDecoration(
              color: Color(0xBF705C42),
              shape: StarBorder.polygon(sides: 4),
            ),
            child: Center(
              child: Text(
                surahEntity.number.toArabicDigits(),
                style: AppFontStyles.styleBold20(context).copyWith(
                  color: Colors.white,
                  fontFamily: 'Scheherazade',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_outlined,
        color: AppColors.greyColor,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          QuranPagesView.routeName,
        );
      },
    );
  }
}

import 'package:fazakir/Features/home/presentation/views/widgets/components_zikr_of_the_day.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class ContainerZikrOfTheDay extends StatelessWidget {
  const ContainerZikrOfTheDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.greyColor.withOpacity(0.32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).mention_of_the_day,
                style: AppFontStyles.styleRegular11(context).copyWith(
                  color: AppColors.greyColor,
                ),
              ),
              Text(
                'أذكار الصباح',
                style: AppFontStyles.styleRegular11(context).copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.',
            textAlign: TextAlign.center,
            style: AppFontStyles.styleRegular24(context).copyWith(
              fontFamily: 'Scheherazade',
            ),
          ),
          const SizedBox(height: 12),
          const ComponentsZikrOfTheDay(),
        ],
      ),
    );
  }
}

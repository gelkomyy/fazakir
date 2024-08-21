import 'package:fazakir/Features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/short_cut_items_list_view.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/row_label_with_show_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const HomeViewBodyHeader(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.assetsImagesTimeElapsedSvg,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'صلاة المغرب بعد ساعة و ٥ دقائق',
                    style: AppFontStyles.styleRegular14(context),
                  ),
                ],
              ),
              const SizedBox(height: 42),
              const RowLabelWithShowMore(
                labelText: 'الاختصارات',
              ),
            ],
          ),
        ),
        const SizedBox(height: 38),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: const ShortCutItemsListView(),
        ),
        const SizedBox(height: 35),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 55),
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
                    'ذكر اليوم من..',
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
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:fazakir/Features/quran/domain/entities/ayah_entity.dart';
import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/ayah_overview_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchInQuranLoadingWidget extends StatelessWidget {
  const SearchInQuranLoadingWidget({
    super.key,
    required this.quranCubit,
  });

  final QuranCubit quranCubit;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) ...[
                  Text(
                    'الآيات'
                    ' (${quranCubit.ayat.length})',
                    style: AppFontStyles.styleBold16(context),
                  ),
                  const SizedBox(height: 12),
                ],
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 16,
                  ),
                  child: Skeletonizer(
                    effect: const ShimmerEffect(
                      baseColor: AppColors.greyColor,
                      highlightColor: AppColors.greyColor2,
                    ),
                    child: AyahOverviewItem(
                        ayahEntity: AyahEntity(
                            ayahNumber: 29, surahNumber: 2, query: 'query')),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

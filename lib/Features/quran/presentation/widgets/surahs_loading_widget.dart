import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/Features/quran/presentation/widgets/surah_overview_item.dart';
import 'package:fazakir/core/enums/revelation_type_enum.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SurahsLoadingWidget extends StatelessWidget {
  const SurahsLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: Clip.none,
      itemCount: 14,
      itemBuilder: (BuildContext context, int index) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: index + 1 == 14 ? 0 : 16,
              ),
              child: Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: AppColors.greyColor.withOpacity(0.7),
                  highlightColor: Colors.grey.shade200,
                ),
                child: SurahOverviewItem(
                  surahEntity: SurahEntity(
                    number: index + 1,
                    name: '',
                    numberOfAyahs: 99,
                    revelationType: RevelationTypeEnum.meccan,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

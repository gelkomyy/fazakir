import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/surah_overview_item.dart';
import 'package:fazakir/core/enums/revelation_type_enum.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is SurahsLoaded) {
            if (state.surahs.isEmpty) {
              return Center(
                child: Text(
                  'لا توجد نتائج',
                  style: AppFontStyles.styleBold20(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
            return ListView.builder(
              clipBehavior: Clip.none,
              itemCount: state.surahs.length,
              itemBuilder: (BuildContext context, int index) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: index + 1 == state.surahs.length ? 0 : 16,
                      ),
                      child: SurahOverviewItem(
                        surahEntity: state.surahs[index],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is SurahsFailure) {
            return Center(
              child: Text(state.errMessage),
            );
          } else {
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
        },
      ),
    );
  }
}

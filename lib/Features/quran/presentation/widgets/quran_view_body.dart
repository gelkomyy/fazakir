import 'dart:developer';

import 'package:fazakir/Features/quran/domain/entities/ayah_entity.dart';
import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/ayah_overview_item.dart';
import 'package:fazakir/Features/quran/presentation/widgets/page_number_quran_overview_item.dart';
import 'package:fazakir/Features/quran/presentation/widgets/quran_juz_overview_item.dart';
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
          if (state is SurahsLoaded ||
              state is SearchInQuranLoaded ||
              state is SearchInQuranLoading) {
            QuranCubit quranCubit = context.read<QuranCubit>();
            log(quranCubit.state.toString());
            if (quranCubit.filteredSurahs.isEmpty &&
                quranCubit.ayat.isEmpty &&
                state is SearchInQuranLoaded) {
              return Center(
                child: Text(
                  'لا توجد نتائج',
                  style: AppFontStyles.styleBold20(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: quranCubit.filteredSurahs.length,
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
                                'السور'
                                ' (${quranCubit.filteredSurahs.length})',
                                style: AppFontStyles.styleBold16(context),
                              ),
                              const SizedBox(height: 12),
                            ],
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                bottom: 16,
                              ),
                              child: SurahOverviewItem(
                                surahEntity: quranCubit.filteredSurahs[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (quranCubit.ayat.isNotEmpty &&
                    quranCubit.ayat.first.queryNum != null)
                  SliverList.builder(
                    itemCount: quranCubit.ayat.length,
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
                                  'الصفحات'
                                  ' (${quranCubit.ayat.length})',
                                  style: AppFontStyles.styleBold16(context),
                                ),
                                const SizedBox(height: 12),
                              ],
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: 16,
                                ),
                                child: PageNumberQuranOverviewItem(
                                    queryNum: quranCubit.ayat.first.queryNum!),
                              ),
                              if (quranCubit.ayat.first.queryNum! <= 30) ...[
                                Text(
                                  'الأجزاء'
                                  ' (${quranCubit.ayat.length})',
                                  style: AppFontStyles.styleBold16(context),
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    bottom: 16,
                                  ),
                                  child: QuranJuzOverviewItem(
                                      juzNumber:
                                          quranCubit.ayat.first.queryNum!),
                                ),
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (state is! SearchInQuranLoaded)
                  SliverList.builder(
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
                                          ayahNumber: 29,
                                          surahNumber: 2,
                                          query: 'query')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (quranCubit.ayat.isNotEmpty &&
                    quranCubit.ayat.first.queryNum == null)
                  SliverList.builder(
                    itemCount: quranCubit.ayat.length,
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
                                child: AyahOverviewItem(
                                    ayahEntity: quranCubit.ayat[index]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          } else if (state is SurahsFailure || state is SearchInQuranFailure) {
            return Center(
              child: Text((state is SurahsFailure
                  ? state.errMessage
                  : (state as SearchInQuranFailure).errMessage)),
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

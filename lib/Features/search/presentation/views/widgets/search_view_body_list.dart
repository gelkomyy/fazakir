import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/ahadith/presentation/views/widgets/container_hadith_item.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_item.dart';
import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBodyList extends StatelessWidget {
  const SearchViewBodyList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.primaryColor,
              ),
            ),
          );
        } else if (state is SearchLoaded) {
          final searchResult = state.searchResult;

          if (searchResult.exactMatches.isNotEmpty) {
            final result = searchResult.exactMatches;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "عدد النتائج : ${result.length}",
                  style: AppFontStyles.styleBold16(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(
                            bottom: index + 1 == result.length ? 0 : 24),
                        child: result[index] is AzkarItemEntity
                            ? ContainerZikrItem(
                                azkarItem: result[index],
                                margin: EdgeInsets.zero,
                                withoutHeader: true,
                              )
                            : result[index] is HadithEntity
                                ? ContainerHadithItem(
                                    hadithEntity: result[index],
                                  )
                                : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (searchResult.relatedMatches.isNotEmpty) {
            final result = searchResult.relatedMatches;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "عدد النتائج : ${result.length}",
                  style: AppFontStyles.styleBold16(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "لم يتم العثور على تطابقات دقيقة. فيما يلي بعض النتائج ذات الصلة :",
                  style: AppFontStyles.styleBold16(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(
                            bottom: index + 1 == result.length ? 0 : 24),
                        child: result[index] is AzkarItemEntity
                            ? ContainerZikrItem(
                                azkarItem: result[index],
                                margin: EdgeInsets.zero,
                                withoutHeader: true,
                              )
                            : result[index] is HadithEntity
                                ? ContainerHadithItem(
                                    hadithEntity: result[index],
                                  )
                                : const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'لا توجد نتائج',
                style: AppFontStyles.styleBold20(context).copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }
        } else if (state is SearchError) {
          return Text('Error: ${state.error}');
        } else {
          return Center(
            child: Image.asset(
              Assets.assetsImagesSearchViewShape2,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }
}

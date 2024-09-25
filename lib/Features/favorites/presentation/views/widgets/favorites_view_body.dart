import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/ahadith/presentation/views/widgets/container_hadith_item.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';
import 'package:fazakir/Features/favorites/presentation/manager/cubits/cubit/favorites_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/about_religion_item.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          );
        } else if (state is FavoritesFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        final FavoritesCubit favoritesCubit = context.read<FavoritesCubit>();
        final List<FavoriteEntity> favList = favoritesCubit.favorites;
        if (favList.isNotEmpty) {
          return ListView.builder(
            clipBehavior: Clip.none,
            itemCount: favList.length,
            itemBuilder: (BuildContext context, int index) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: index + 1 == favList.length ? 110 : 32,
                    top: index == 0 ? 24 : 0,
                  ),
                  child: favList[index] is VideoYoutubeEntity
                      ? AboutReligionItem(
                          videoYoutubeEntity:
                              favList[index] as VideoYoutubeEntity,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                        )
                      : favList[index] is AzkarItemEntity
                          ? ContainerZikrItem(
                              azkarItem: favList[index] as AzkarItemEntity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              withoutHeader: true,
                            )
                          : favList[index] is HadithEntity
                              ? ContainerHadithItem(
                                  hadithEntity: favList[index] as HadithEntity,
                                )
                              : const SizedBox(),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              'لا يوجد مفضلات',
            ),
          );
        }
      },
    );
  }
}

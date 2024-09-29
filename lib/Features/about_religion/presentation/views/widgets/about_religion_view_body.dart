import 'package:fazakir/Features/about_religion/presentation/manager/cubits/manage_about_religion_cubit/manage_about_religion_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/about_religion_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutReligionViewBody extends StatelessWidget {
  const AboutReligionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageAboutReligionCubit, ManageAboutReligionState>(
      builder: (context, state) {
        if (state is VideosYoutubeSuccess) {
          if (state.videoYoutubeEntities.isEmpty) {
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
            itemCount: state.videoYoutubeEntities.length,
            itemBuilder: (BuildContext context, int index) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom:
                        index + 1 == state.videoYoutubeEntities.length ? 0 : 32,
                    top: index == 0 ? 24 : 0,
                  ),
                  child: AboutReligionItem(
                    videoYoutubeEntity: state.videoYoutubeEntities[index],
                    width: MediaQuery.sizeOf(context).width * 0.9,
                  ),
                ),
              );
            },
          );
        } else if (state is VideosYoutubeFailure) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            ),
          );
        }
      },
    );
  }
}

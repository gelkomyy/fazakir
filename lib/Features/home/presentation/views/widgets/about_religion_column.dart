import 'package:fazakir/Features/about_religion/presentation/manager/cubits/manage_about_religion_cubit/manage_about_religion_cubit.dart';
import 'package:fazakir/Features/about_religion/presentation/views/about_religion_view.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/about_religion_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/widgets/row_label_with_show_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutReligionColumn extends StatelessWidget {
  const AboutReligionColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowLabelWithShowMore(
            labelText: 'بودكاست',
            onTapShowMore: () {
              Navigator.pushNamed(context, AboutReligionView.routeName);
            },
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.005,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.17,
            child:
                BlocBuilder<ManageAboutReligionCubit, ManageAboutReligionState>(
              builder: (context, state) {
                if (state is VideosYoutubeSuccess) {
                  return ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: index + 1 == 10 ? 0 : 14),
                          child: AboutReligionItem(
                            pushToVideoPlayerView: true,
                            videoYoutubeEntity:
                                state.videoYoutubeEntities[index],
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

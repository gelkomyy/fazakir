import 'package:fazakir/Features/about_religion/domain/data/repos/video_youtube_repo_impl.dart';
import 'package:fazakir/Features/about_religion/presentation/manager/cubits/manage_about_religion_cubit/manage_about_religion_cubit.dart';
import 'package:fazakir/Features/about_religion/presentation/views/widgets/about_religion_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class AboutReligionView extends StatelessWidget {
  const AboutReligionView({super.key});

  static const String routeName = 'aboutReligionView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageAboutReligionCubit(
        VideoYoutubeRepoImpl(),
      )..fetchVideos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).about_religion,
            style: AppFontStyles.styleBold20(context),
          ),
          centerTitle: true,
          actions: [
            Bounceable(
              child: Card(
                color: AppColors.textBlackColor,
                shape: const CircleBorder(),
                margin: const EdgeInsetsDirectional.only(end: 24),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: SvgPicture.asset(
                    Assets.assetsImagesSearchIconSvg,
                    width: 19,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          leading: Bounceable(
            child: const Card(
              color: AppColors.textBlackColor,
              shape: CircleBorder(),
              margin: EdgeInsetsDirectional.only(start: 24),
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: const SafeArea(
          child: AboutReligionViewBody(),
        ),
      ),
    );
  }
}

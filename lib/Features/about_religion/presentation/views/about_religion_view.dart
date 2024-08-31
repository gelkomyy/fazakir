import 'package:fazakir/Features/about_religion/presentation/views/widgets/about_religion_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class AboutReligionView extends StatelessWidget {
  const AboutReligionView({super.key});

  static const String routeName = 'aboutReligionView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about_religion),
        centerTitle: true,
        actions: [
          Bounceable(
            child: Card(
              color: AppColors.textBlackColor,
              shape: const CircleBorder(),
              margin: const EdgeInsetsDirectional.only(end: 24),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  Assets.assetsImagesSearchIconSvg,
                  width: 20,
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
        leadingWidth: 64,
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
    );
  }
}

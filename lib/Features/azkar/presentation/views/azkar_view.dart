import 'package:fazakir/Features/azkar/presentation/views/widgets/azkar_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});
  static const String routeName = 'azkarView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الادعية والاذكار',
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
        child: AzkarViewBody(),
      ),
    );
  }
}

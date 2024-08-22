import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutReligionItem extends StatelessWidget {
  const AboutReligionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.77,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.assetsImagesTestPreviewImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'بودكاست: ',
                    style: AppFontStyles.styleBold10(context)
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  TextSpan(
                    text: 'أول مرة أتذوق الصلاة!',
                    style: AppFontStyles.styleBold10(context),
                  ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
            SvgPicture.asset(Assets.assetsImagesScreenDisplayShapeSvg),
          ],
        )
      ],
    );
  }
}

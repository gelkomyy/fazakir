import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutReligionItem extends StatelessWidget {
  const AboutReligionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.425,
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
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.425,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.of(context).podcast,
                        style: AppFontStyles.styleBold10(context)
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      TextSpan(
                        text: ' أول مرة أتذوق الصلاة!',
                        style: AppFontStyles.styleBold10(context),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 6,
                ),
                child: SvgPicture.asset(
                  Assets.assetsImagesScreenDisplayShapeSvg,
                  width: 13,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

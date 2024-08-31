import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutReligionItem extends StatelessWidget {
  const AboutReligionItem({super.key, this.width});
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width ?? MediaQuery.sizeOf(context).width * 0.425,
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                AspectRatio(
                  aspectRatio: 1.77,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.assetsImagesTestPreviewImage),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Bounceable(
                        child: Card(
                          color: Colors.transparent,
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          child: Padding(
                            padding: EdgeInsets.all(width == null ? 4 : 6),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: width == null ? 18 : 32,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(width == null ? 5 : 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(8),
                    ),
                  ),
                  child: SvgPicture.asset(
                    Assets.assetsImagesHeartBlackIconSvg,
                    width: width == null ? 12 : 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.redColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: width ?? MediaQuery.sizeOf(context).width * 0.425,
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
                          style: width == null
                              ? AppFontStyles.styleBold10(context)
                                  .copyWith(color: AppColors.primaryColor)
                              : AppFontStyles.styleBold13(context)
                                  .copyWith(color: AppColors.primaryColor),
                        ),
                        TextSpan(
                          text: ' أول مرة أتذوق الصلاة!',
                          style: width == null
                              ? AppFontStyles.styleBold10(context)
                              : AppFontStyles.styleBold13(context),
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
                    width: width == null ? 13 : 18,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

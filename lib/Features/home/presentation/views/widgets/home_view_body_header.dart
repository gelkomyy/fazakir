import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeViewBodyHeader extends StatelessWidget {
  const HomeViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      clipBehavior: Clip.antiAlias,
      children: [
        SvgPicture.asset(
          Assets.assetsImagesHomeHeaderShapeSvg,
          fit: BoxFit.fill,
          height: MediaQuery.sizeOf(context).height * 0.16,
          alignment: Alignment.topCenter,
        ),
        PositionedDirectional(
          bottom: 52,
          start: 0,
          end: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'اهلا بيك',
                      textAlign: TextAlign.right,
                      style: AppFontStyles.styleBold16(context).copyWith(
                        fontFamily: 'Almarai',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(Assets.assetsImagesWhiteHeart),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: 36,
                  child: const CustomTextField(
                    hintText: 'ابحث عن ذكر أو قارئ ...',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

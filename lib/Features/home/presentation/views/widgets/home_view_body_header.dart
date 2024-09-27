import 'package:fazakir/Features/search/presentation/views/search_view.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_search_text_field.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeViewBodyHeader extends StatelessWidget {
  const HomeViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final S txt = S.of(context);
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(
            Assets.assetsImagesHomeHeaderShapeSvg,
            fit: BoxFit.fill,
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
                        txt.welcome,
                        textAlign: TextAlign.right,
                        style: AppFontStyles.styleBold16(context).copyWith(
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SearchView.routeName);
                      },
                      child: CustomSearchTextField(
                        enabled: false,
                        hintText: txt.search_mention_or_reciter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

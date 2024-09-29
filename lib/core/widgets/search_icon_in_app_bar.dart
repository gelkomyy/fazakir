import 'package:fazakir/Features/search/presentation/views/search_view.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class SearchIconInAppBar extends StatelessWidget {
  const SearchIconInAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
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
        Navigator.pushNamed(context, SearchView.routeName);
      },
    );
  }
}

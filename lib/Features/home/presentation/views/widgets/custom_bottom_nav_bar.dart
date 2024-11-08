import 'package:fazakir/Features/home/presentation/manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_bottom_nav_bar_models.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_nav_bar.dart';
import 'package:fazakir/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return CustomNavBar(
      navBarEssentials: NavBarEssentials(
        navBarHeight: null /* getResponsiveFontSize(context, fontSize: 80) */,
        items: buildNavBarItems,
        selectedIndex: selectedIndex,
        backgroundColor: context.watch<ThemeCubit>().state.isDark
            ? AppColors.textBlackColor
            : Colors.white,
        itemAnimationProperties: const ItemAnimationSettings(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        onItemSelected: (int index) {
          context.read<NavigationCubit>().navigationIndexView(index);
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: 18,
        ),
        navBarItemsAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  List<PersistentBottomNavBarItem> get buildNavBarItems {
    return [
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesHomeIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesHomeIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: S.current.your_home,
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesAlarmIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesAlarmIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: S.current.prayer_times,
        iconSize: 28,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesSibhaIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesSibhaIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: S.current.sebha,
        iconSize: 28,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesHeartBlackIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesHeartBlackIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: S.current.favorites,
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesSettingsIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesSettingsIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: S.current.settings,
        iconSize: 22,
      ),
    ];
  }
}

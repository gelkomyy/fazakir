import 'dart:developer';

import 'package:fazakir/Features/home/presentation/views/widgets/custom_bottom_nav_bar_models.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_nav_bar.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomNavBar(
      navBarEssentials: NavBarEssentials(
        navBarHeight: 90,
        items: buildNavBarItems,
        selectedIndex: 3,
        backgroundColor: Colors.white,
        itemAnimationProperties: const ItemAnimationSettings(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        onItemSelected: (int index) {
          log('index: $index');
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: 10,
        ),
        navBarItemsAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  List<PersistentBottomNavBarItem> get buildNavBarItems {
    return [
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesHeartBlackIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesHeartBlackIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'favorite',
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesNotificationIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesNotificationIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Notifications',
        iconSize: 22,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesHomeIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesHomeIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Home',
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesAlarmIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesAlarmIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Timeline',
        iconSize: 28,
      ),
      PersistentBottomNavBarItem(
        svgAsset: Assets.assetsImagesSettingsIconSvg,
        icon: SvgPicture.asset(
          Assets.assetsImagesSettingsIconSvg,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Settings',
        iconSize: 22,
      ),
    ];
  }
}

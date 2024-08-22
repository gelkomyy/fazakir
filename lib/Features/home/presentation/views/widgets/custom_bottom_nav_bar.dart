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
        selectedIndex: 2,
        backgroundColor: Colors.white,
        itemAnimationProperties: const ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
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
        icon: SvgPicture.asset(
          Assets.assetsImagesHeartBlackIconSvg,
          width: 26,
          colorFilter:
              const ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'favorite',
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.assetsImagesNotificationIconSvg,
          width: 22,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Notifications',
        iconSize: 22,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.assetsImagesHomeIconSvg,
          width: 26,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Home',
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.assetsImagesAlarmIconSvg,
          width: 28,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Timeline',
        iconSize: 28,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.assetsImagesSettingsIconSvg,
          width: 22,
        ),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.greyColor,
        title: 'Settings',
        iconSize: 22,
      ),
    ];
  }
}

import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsListModel {
  final String title;
  final String svgIconAsset;
  final Widget traillingWidget;
  final void Function()? onTap;

  const SettingsListModel({
    required this.title,
    required this.svgIconAsset,
    this.traillingWidget = const Icon(
      Icons.arrow_forward_outlined,
      color: AppColors.greyColor,
    ),
    this.onTap,
  });

  Widget buildList(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: svgIconAsset.contains('flag') ? 0 : 32,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 2,
        ),
        horizontalTitleGap: 10,
        visualDensity: const VisualDensity(
          horizontal: -4,
          vertical: -4,
        ),
        tileColor: const Color(0x51BBBBBB),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        title: Text(
          title,
          style: AppFontStyles.styleRegular14(context),
        ),
        leading: SvgPicture.asset(
          svgIconAsset,
          width: 18,
          height: 18,
        ),
        trailing: traillingWidget,
        onTap: onTap,
      ),
    );
  }

  static List<SettingsListModel> get settingsList => [
        SettingsListModel(
          title: 'مواعيد التذكيرات',
          svgIconAsset: Assets.assetsImagesTazkeerIconSvg,
          onTap: () {},
        ),
        const SettingsListModel(
          title: 'التذكيرات',
          svgIconAsset: Assets.assetsImagesAtazkeerIconSvg,
          traillingWidget: CustomSwitch(),
        ),
        const SettingsListModel(
          title: 'الوضع الليلي',
          svgIconAsset: Assets.assetsImagesMoonIconSvg,
          traillingWidget: CustomSwitch(),
        ),
        SettingsListModel(
          title: 'ما هو فذكر',
          svgIconAsset: Assets.assetsImagesAboutIconSvg,
          onTap: () {},
        ),
        SettingsListModel(
          title: 'تقييمك لينا',
          svgIconAsset: Assets.assetsImagesLikeIconSvg,
          onTap: () {},
        ),
        const SettingsListModel(
          title: 'صناع التطبيق',
          svgIconAsset: Assets.assetsImagesFlagIconSvg,
          traillingWidget: Icon(
            Icons.arrow_downward_outlined,
            color: AppColors.greyColor,
          ),
        ),
      ];
}
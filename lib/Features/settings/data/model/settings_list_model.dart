import 'package:fazakir/Features/settings/presentation/widgets/about_app_dialog.dart';
import 'package:fazakir/Features/settings/presentation/widgets/notify_duration_dialog.dart';
import 'package:fazakir/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:fazakir/core/utils/notifications_service.dart';
import 'package:fazakir/core/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        tileColor: AppColors.greyColor2,
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
}

List<SettingsListModel> getSettingsList(BuildContext context) => [
      SettingsListModel(
        title: 'مواعيد التذكيرات',
        svgIconAsset: Assets.assetsImagesTazkeerIconSvg,
        onTap: () {
          showNotifyDurationDialog(context);
        },
      ),
      SettingsListModel(
        title: 'التذكيرات',
        svgIconAsset: Assets.assetsImagesAtazkeerIconSvg,
        traillingWidget: CustomSwitch(
          isEnable: getIt<SharedPreferences>().getBool('send_notify') ?? true,
          onChanged: (value) {
            NotificationService.setSendNotify(value);
            getIt<SharedPreferences>().setBool('send_notify', value);
          },
        ),
      ),
      SettingsListModel(
        title: 'الوضع الليلي',
        svgIconAsset: Assets.assetsImagesMoonIconSvg,
        traillingWidget: CustomSwitch(
          onChanged: (value) {
            context.read<ThemeCubit>().toggleTheme();
            getIt<SharedPreferences>().setBool('isDarkMode', value);
          },
        ),
      ),
      SettingsListModel(
        title: 'ما هو فذكر',
        svgIconAsset: Assets.assetsImagesAboutIconSvg,
        onTap: () {
          showAboutAppDialog(context);
        },
      ),
      SettingsListModel(
        title: 'تقييمك لينا',
        svgIconAsset: Assets.assetsImagesLikeIconSvg,
        onTap: () {
          openLink(
              'https://play.google.com/store/apps/details?id=com.fazakir.elkomy');
        },
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

import 'package:fazakir/Features/home/presentation/views/widgets/custom_short_cut_image_shape.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class ShortCutsViewBody extends StatelessWidget {
  const ShortCutsViewBody({super.key});
  static const List<Map<String, String>> shortcuts = [
    {
      "title": "القران الكريم",
      "AssetImage": Assets.assetsImagesQuranImage,
    },
    {
      "title": "الادعية والاذكار",
      "AssetImage": Assets.assetsImagesAzkarShortcut,
    },
    {
      "title": "الاحاديث النبوية",
      "AssetImage": Assets.assetsImagesAhadithShortcut,
    },
    {
      "title": "عن الدين",
      "AssetImage": Assets.assetsImagesReligionShortcut,
    },
    {
      "title": "أوقات الصلاة",
      "AssetImage": Assets.assetsImagesPrayerShortcut,
    },
    {
      "title": "الرقية الشرعية",
      "AssetImage": Assets.assetsImagesRuqyaShortcut,
    },
    {
      "title": "السبحة",
      "AssetImage": Assets.assetsImagesSibhaShortcut,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 24,
      ),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
            Row(
              children: [
                Bounceable(
                  scaleFactor: 0.5,
                  child: const Card(
                    color: AppColors.textBlackColor,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Text(
                  S.of(context).shortcuts,
                  style: AppFontStyles.styleBold20(context),
                ),
                const SizedBox(
                  width: 32,
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: MediaQuery.sizeOf(context).width * 0.15,
              runSpacing: 24,
              children: shortcuts
                  .map(
                    (shortcut) => SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      child: CustomShortCutImageShape(
                        title: shortcut["title"] ?? '',
                        assetImage: shortcut["AssetImage"] ?? '',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

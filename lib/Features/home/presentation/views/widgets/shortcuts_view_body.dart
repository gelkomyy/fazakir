import 'package:fazakir/Features/about_religion/presentation/views/about_religion_view.dart';
import 'package:fazakir/Features/ahadith/presentation/views/a_6books_of_hadith_view.dart';
import 'package:fazakir/Features/azkar/presentation/views/azkar_view.dart';
import 'package:fazakir/Features/azkar/presentation/views/ruqyah_view.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_short_cut_image_shape.dart';
import 'package:fazakir/Features/sebha/presentation/views/saved_azkar_view.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bounceable/flutter_bounceable.dart';

class ShortCutsViewBody extends StatelessWidget {
  const ShortCutsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> shortcuts = [
      {
        "title": "القران الكريم",
        "AssetImage": Assets.assetsImagesQuranImage,
      },
      {
        "title": "الادعية والاذكار",
        "AssetImage": Assets.assetsImagesAzkarShortcut,
        "onTap": () {
          Navigator.pushNamed(context, AzkarView.routeName);
        },
      },
      {
        "title": "الاحاديث النبوية",
        "AssetImage": Assets.assetsImagesAhadithShortcut,
        "onTap": () {
          Navigator.pushNamed(context, A6BooksOfHadithView.routeName);
        },
      },
      {
        "title": "عن الدين",
        "AssetImage": Assets.assetsImagesReligionShortcut,
        "onTap": () {
          Navigator.pushNamed(context, AboutReligionView.routeName);
        }
      },
      {
        "title": "الرقية الشرعية",
        "AssetImage": Assets.assetsImagesRuqyaShortcut,
        "onTap": () {
          Navigator.pushNamed(context, RuqyahView.routeName);
        }
      },
      {
        "title": "السبحة",
        "AssetImage": Assets.assetsImagesSibhaShortcut,
        "onTap": () {
          Navigator.pushNamed(context, SavedAzkarView.routeName);
        },
      }
    ];
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
                        onTap: shortcut["onTap"],
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

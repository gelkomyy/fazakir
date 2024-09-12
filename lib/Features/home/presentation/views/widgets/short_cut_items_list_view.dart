import 'package:fazakir/Features/azkar/presentation/views/azkar_view.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_short_cut_image_shape.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class ShortCutItemsListView extends StatelessWidget {
  const ShortCutItemsListView({
    super.key,
  });
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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      itemCount: shortcuts.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
              end: index + 1 == shortcuts.length ? 0 : 12),
          child: CustomShortCutImageShape(
            title: shortcuts[index]["title"] ?? '',
            assetImage: shortcuts[index]["AssetImage"] ?? '',
            onTap: shortcuts[index]["onTap"],
          ),
        );
      },
    );
  }
}

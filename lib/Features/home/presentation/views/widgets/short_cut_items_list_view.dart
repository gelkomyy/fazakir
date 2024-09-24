import 'package:fazakir/Features/about_religion/presentation/views/about_religion_view.dart';
import 'package:fazakir/Features/ahadith/presentation/views/a_6books_of_hadith_view.dart';
import 'package:fazakir/Features/azkar/presentation/views/azkar_view.dart';
import 'package:fazakir/Features/azkar/presentation/views/ruqyah_view.dart';
import 'package:fazakir/Features/home/presentation/manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_short_cut_image_shape.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        "onTap": () {
          Navigator.pushNamed(context, A6BooksOfHadithView.routeName);
        },
      },
      {
        "title": "الرقية الشرعية",
        "AssetImage": Assets.assetsImagesRuqyaShortcut,
        "onTap": () {
          Navigator.pushNamed(context, RuqyahView.routeName);
        }
      },
      {
        "title": "عن الدين",
        "AssetImage": Assets.assetsImagesReligionShortcut,
        "onTap": () {
          Navigator.pushNamed(context, AboutReligionView.routeName);
        }
      },
      {
        "title": "أوقات الصلاة",
        "AssetImage": Assets.assetsImagesPrayerShortcut,
        "onTap": () {
          context.read<NavigationCubit>().navigationIndexView(1);
        }
      },
      {
        "title": "السبحة",
        "AssetImage": Assets.assetsImagesSibhaShortcut,
        "onTap": () {
          context.read<NavigationCubit>().navigationIndexView(2);
          //Navigator.pushNamed(context, SavedAzkarView.routeName);
        },
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

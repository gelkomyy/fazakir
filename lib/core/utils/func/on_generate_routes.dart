import 'package:fazakir/Features/about_religion/presentation/views/about_religion_view.dart';
import 'package:fazakir/Features/about_religion/presentation/views/video_player_view.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/Features/azkar/presentation/views/azkar_view.dart';
import 'package:fazakir/Features/azkar/presentation/views/ruqyah_view.dart';
import 'package:fazakir/Features/azkar/presentation/views/zikr_view.dart';
import 'package:fazakir/Features/home/presentation/views/navigation_page.dart';
import 'package:fazakir/Features/home/presentation/views/shortcuts_view.dart';
import 'package:fazakir/Features/intro/presentation/views/intro_view.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/qiblah_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case NavigationPage.routeName:
      return MaterialPageRoute(builder: (context) => const NavigationPage());
    case IntroView.routeName:
      return MaterialPageRoute(builder: (context) => const IntroView());
    case QiblahView.routeName:
      return MaterialPageRoute(builder: (context) => const QiblahView());
    case AboutReligionView.routeName:
      return MaterialPageRoute(builder: (context) => const AboutReligionView());
    case VideoPlayerView.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
          builder: (context) => VideoPlayerView(
                videoUrl: args?['videoUrl'] ?? '',
              ));
    case ShortCutsView.routeName:
      return MaterialPageRoute(builder: (context) => const ShortCutsView());
    case AzkarView.routeName:
      return MaterialPageRoute(builder: (context) => const AzkarView());
    case RuqyahView.routeName:
      return MaterialPageRoute(builder: (context) => const RuqyahView());
    case ZikrView.routeName:
      return MaterialPageRoute(
          builder: (context) => ZikrView(
                azkar: settings.arguments as AzkarCategoryEntity,
              ));
    default:
      return MaterialPageRoute(builder: (context) => const NavigationPage());
  }
}

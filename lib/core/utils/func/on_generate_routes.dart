import 'package:fazakir/Features/about_religion/presentation/views/about_religion_view.dart';
import 'package:fazakir/Features/about_religion/presentation/views/video_player_view.dart';
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
    default:
      return MaterialPageRoute(builder: (context) => const NavigationPage());
  }
}

import 'package:fazakir/Features/about_religion/presentation/views/about_religion_view.dart';
import 'package:fazakir/Features/home/presentation/views/navigation_page.dart';
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
    default:
      return MaterialPageRoute(builder: (context) => const NavigationPage());
  }
}

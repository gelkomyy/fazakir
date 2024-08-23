import 'package:fazakir/Features/home/presentation/views/navigation_page.dart';
import 'package:fazakir/Features/intro/presentation/views/intro_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case NavigationPage.routeName:
      return MaterialPageRoute(builder: (context) => const NavigationPage());
    case IntroView.routeName:
      return MaterialPageRoute(builder: (context) => const IntroView());
    default:
      return MaterialPageRoute(builder: (context) => const NavigationPage());
  }
}

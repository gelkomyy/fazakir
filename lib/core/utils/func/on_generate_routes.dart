import 'package:fazakir/Features/home/presentation/views/home_view.dart';
import 'package:fazakir/Features/intro/presentation/views/intro_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case IntroView.routeName:
      return MaterialPageRoute(builder: (context) => const IntroView());
    default:
      return MaterialPageRoute(builder: (context) => const HomeView());
  }
}

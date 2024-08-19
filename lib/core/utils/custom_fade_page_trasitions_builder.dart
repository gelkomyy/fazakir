import 'package:flutter/material.dart';

class CustomFadePageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomFadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (animation.status == AnimationStatus.forward) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    } else {
      return child;
    }
  }
}

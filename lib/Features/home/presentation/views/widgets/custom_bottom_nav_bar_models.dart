import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ItemAnimationSettings {
  const ItemAnimationSettings(
      {this.duration = const Duration(milliseconds: 400),
      this.curve = Curves.ease});
  final Duration duration;
  final Curve curve;
}

class RouteAndNavigatorSettings {
  const RouteAndNavigatorSettings({
    this.defaultTitle,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.initialRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.navigatorKey,
  });
  final String? defaultTitle;

  final Map<String, WidgetBuilder>? routes;

  final RouteFactory? onGenerateRoute;

  final RouteFactory? onUnknownRoute;

  final String? initialRoute;

  final List<NavigatorObserver> navigatorObservers;

  final GlobalKey<NavigatorState>? navigatorKey;

  RouteAndNavigatorSettings copyWith({
    final String? defaultTitle,
    final Map<String, WidgetBuilder>? routes,
    final RouteFactory? onGenerateRoute,
    final RouteFactory? onUnknownRoute,
    final String? initialRoute,
    final List<NavigatorObserver>? navigatorObservers,
    final GlobalKey<NavigatorState>? navigatorKeys,
  }) =>
      RouteAndNavigatorSettings(
        defaultTitle: defaultTitle ?? this.defaultTitle,
        routes: routes ?? this.routes,
        onGenerateRoute: onGenerateRoute ?? this.onGenerateRoute,
        onUnknownRoute: onUnknownRoute ?? this.onUnknownRoute,
        initialRoute: initialRoute ?? this.initialRoute,
        navigatorObservers: navigatorObservers ?? this.navigatorObservers,
        navigatorKey: navigatorKey ?? navigatorKey,
      );
}

///An item widget for the `PersistentTabView`.
class PersistentBottomNavBarItem {
  PersistentBottomNavBarItem(
      {required this.icon,
      this.inactiveIcon,
      this.title,
      this.contentPadding = 5.0,
      this.activeColorPrimary = CupertinoColors.activeBlue,
      this.activeColorSecondary,
      this.inactiveColorPrimary,
      this.inactiveColorSecondary = CupertinoColors.systemGrey,
      this.opacity = 1.0,
      this.filter,
      this.textStyle,
      this.iconSize = 26.0,
      this.onSelectedTabPressWhenNoScreensPushed,
      this.iconAnimationController,
      this.scrollController,
      this.routeAndNavigatorSettings,
      this.scrollToTopOnNavBarItemPress = true,
      this.onPressed})
      : assert(opacity >= 0 && opacity <= 1.0,
            "Opacity cannot be greater than 1 and less than 0");

  ///Icon for the bar item.
  final Widget icon;

  ///In-Active icon for the bar item. This is an optional property and will only be used if defined.
  final Widget? inactiveIcon;

  ///Title for the bar item. Might not appear is some `styles`.
  final String? title;

  ///Color for the current selected item in the navigation bar. If `activeColorSecondary` property is empty, this will act in its place (recommended). `cupertino activeBlue` by default.
  final Color activeColorPrimary;

  ///Color for the unselected item(s) in the navigation bar.
  final Color? inactiveColorPrimary;

  ///Color for the item's `icon` and `title`. In most styles, declaring the the `activeColorPrimary` will be enough. But in some styles like `style7`, this might come help in differentiating the colors.
  final Color? activeColorSecondary;

  ///Color for the item's `inactiveIcon` and `title`. In most styles, declaring the the `inactiveColorPrimary` will be enough. But in some styles like `style7`, this might come help in differentiating the colors.
  final Color inactiveColorSecondary;

  ///Padding of the navigation bar item. Applies on all sides. `5.0` by default.
  ///
  ///`USE WITH CAUTION, MAY BREAK THE NAV BAR`.
  final double contentPadding;

  ///Enables and controls the transparency effect of the entire NavBar when this tab is selected.
  ///
  ///`Warning: Screen will cover the entire extent of the display`
  final double opacity;

  ///If you want custom behavior on a press of a NavBar item like display a modal screen, you can declare your logic here.
  ///
  ///NOTE: This will override the default tab switiching behavior for this particular item.
  final Function(BuildContext?)? onPressed;

  ///Use it when you want to run some code when user presses the NavBar when on the initial screen of that respective tab. The inspiration was taken from the native iOS navigation bar behavior where when performing similar operation, you taken to the top of the list.
  ///
  ///NOTE: This feature is experimental at the moment and might not work as intended for some.
  final VoidCallback? onSelectedTabPressWhenNoScreensPushed;

  ///Filter used when `opacity < 1.0`. Can be used to create 'frosted glass' effect.
  ///
  ///By default -> `ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0)`.
  final ImageFilter? filter;

  ///`TextStyle` of the title's text.
  final TextStyle? textStyle;

  final double iconSize;

  final RouteAndNavigatorSettings? routeAndNavigatorSettings;

  ///For animated icons to work, this property must not be `null` or left empty.
  final AnimationController? iconAnimationController;

  ///For `scrollToTopOnNavBarItemPress` to work, this property must not be `null` or left empty.
  final ScrollController? scrollController;

  ///If an already selected navigation bar is tapped again, the scroll controller provided in `PersistentBottomNavBarItem` will animate to top.
  final bool scrollToTopOnNavBarItemPress;
}

class NavBarEssentials {
  const NavBarEssentials({
    required this.items,
    required this.selectedIndex,
    required this.backgroundColor,
    required this.itemAnimationProperties,
    required this.onItemSelected,
    required this.padding,
    required this.margin,
    required this.navBarItemsAlignment,
    this.selectedScreenBuildContext,
    this.navBarHeight = 0.0,
  });

  final int selectedIndex;
  final Color backgroundColor;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int>? onItemSelected;
  final double navBarHeight;
  final EdgeInsets padding;
  final ItemAnimationSettings itemAnimationProperties;
  final BuildContext? selectedScreenBuildContext;
  final MainAxisAlignment navBarItemsAlignment;
  final EdgeInsets margin;

  NavBarEssentials copyWith({
    final int? selectedIndex,
    final int? previousIndex,
    final double? iconSize,
    final Color? backgroundColor,
    final List<PersistentBottomNavBarItem>? items,
    final ValueChanged<int>? onItemSelected,
    final double? navBarHeight,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final Function(int)? popAllScreensForTheSelectedTab,
    final ItemAnimationSettings? itemAnimationProperties,
    final BuildContext? selectedScreenBuildContext,
    final MainAxisAlignment? navBarItemsAlignment,
  }) =>
      NavBarEssentials(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        items: items ?? this.items,
        onItemSelected: onItemSelected ?? this.onItemSelected,
        navBarHeight: navBarHeight ?? this.navBarHeight,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        itemAnimationProperties:
            itemAnimationProperties ?? this.itemAnimationProperties,
        selectedScreenBuildContext:
            selectedScreenBuildContext ?? this.selectedScreenBuildContext,
        navBarItemsAlignment: navBarItemsAlignment ?? this.navBarItemsAlignment,
      );
}

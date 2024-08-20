import 'package:fazakir/Features/intro/presentation/views/intro_view.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/custom_fade_page_trasitions_builder.dart';
import 'package:fazakir/core/utils/func/on_generate_routes.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const Fazakir());
}

class Fazakir extends StatelessWidget {
  const Fazakir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoutes,
      initialRoute: IntroView.routeName,
      locale: const Locale('en'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // title: S.of(context).app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomFadePageTransitionsBuilder(),
            TargetPlatform.iOS: CustomFadePageTransitionsBuilder(),
          },
        ),
        primarySwatch: AppColors.primarySwatch,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.secondaryColor,
        fontFamily: 'Scheherazade',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.textBlackColor,
              displayColor: AppColors.textBlackColor,
              fontFamily: 'Scheherazade',
            ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.primaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}

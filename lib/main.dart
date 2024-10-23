import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:fazakir/Features/ahadith/presentation/manager/cubits/hadith_processing_cubit/hadith_processing_cubit.dart';
import 'package:fazakir/Features/favorites/presentation/manager/cubits/cubit/favorites_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/navigation_page.dart';
import 'package:fazakir/Features/intro/presentation/views/intro_view.dart';
import 'package:fazakir/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:fazakir/core/flutter_quran/lib/src/utils/flutter_quran_utils.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/custom_bloc_observer.dart';
import 'package:fazakir/core/utils/custom_fade_page_trasitions_builder.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:fazakir/core/utils/func/on_generate_routes.dart';
import 'package:fazakir/core/utils/notifications_service.dart';
import 'package:fazakir/core/utils/object_box_manager.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterQuran().init();
  Bloc.observer = CustomBlocObserver();
  await Future.wait([
    getItSetup(),
    ObjectBoxManager.initialize(),
    NotificationService.initNotification(),
    AndroidAlarmManager.initialize(),
  ]);
  NotificationService.scheduleNotification();
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: const Fazakir(),
  ));
}

class Fazakir extends StatelessWidget {
  const Fazakir({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesCubit()..getFavorites(),
        ),
        BlocProvider(
          create: (context) => HadithProcessingCubit(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            onGenerateRoute: onGenerateRoutes,
            initialRoute:
                getIt<SharedPreferences>().getBool('seen_intro') == true
                    ? NavigationPage.routeName
                    : IntroView.routeName,
            locale: const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'فذكر',
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
              fontFamily: 'Almarai',
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: AppColors.textBlackColor,
                    displayColor: AppColors.textBlackColor,
                    fontFamily: 'Almarai',
                  ),
              buttonTheme: const ButtonThemeData(
                buttonColor: AppColors.primaryColor,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomFadePageTransitionsBuilder(),
                  TargetPlatform.iOS: CustomFadePageTransitionsBuilder(),
                },
              ),
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.textBlackColor,
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: AppColors.secondaryColor,
                    displayColor: AppColors.secondaryColor,
                    fontFamily: 'Almarai',
                  ),
              buttonTheme: const ButtonThemeData(
                buttonColor: AppColors.primaryColor,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            themeMode: themeState == ThemeState.light
                ? ThemeMode.light
                : ThemeMode.dark,
          );
        },
      ),
    );
  }
}

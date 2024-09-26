import 'package:fazakir/Features/ahadith/presentation/manager/cubits/hadith_processing_cubit/hadith_processing_cubit.dart';
import 'package:fazakir/Features/favorites/presentation/manager/cubits/cubit/favorites_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/navigation_page.dart';
import 'package:fazakir/Features/intro/presentation/views/intro_view.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/custom_bloc_observer.dart';
import 'package:fazakir/core/utils/custom_fade_page_trasitions_builder.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:fazakir/core/utils/func/on_generate_routes.dart';
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
  Bloc.observer = CustomBlocObserver();
  await getItSetup();
  runApp(const Fazakir());
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
          create: (context) => HadithProcessingCubit()..processHadiths(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: onGenerateRoutes,
        initialRoute: getIt<SharedPreferences>().getBool('seen_intro') == true
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
      ),
    );
  }
}

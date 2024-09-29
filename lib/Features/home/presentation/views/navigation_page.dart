import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/azkar/presentation/manager/cubits/manage_azkar_cubit/manage_azkar_cubit.dart';
import 'package:fazakir/Features/favorites/presentation/views/favorites_view.dart';
import 'package:fazakir/Features/home/presentation/manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/home_view.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:fazakir/Features/sebha/presentation/views/saved_azkar_view.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});
  static const String routeName = 'navigationPage';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => ManageAzkarCubit(
            getIt<AzkarRepoImpl>(),
          )..fetchRandomZikr(),
        ),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (popBool, result) {
              if (state == 0) {
                /*  showExitConfirmation(context).then(
                      (shouldExit) {
                        if (shouldExit ?? false) {
                          SystemNavigator.pop();
                        }
                      },
                    ); */
              } else {
                // Handle navigation index change if the state is not 0

                context.read<NavigationCubit>().backNavigation();
              }
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    child: getPage(state),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: CustomBottomNavBar(
                        selectedIndex: state,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const PrayerTimesView();
      case 2:
        return const SavedAzkarView(
          fromNavigation: true,
        );
      case 3:
        return const FavoritesView();
      case 4:
        return const HomeView();
      default:
        return const HomeView();
    }
  }
}

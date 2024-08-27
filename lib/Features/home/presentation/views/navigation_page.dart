import 'package:fazakir/Features/home/presentation/manager/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/home_view.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/prayer_times_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});
  static const String routeName = 'navigationPage';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
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
              bottomNavigationBar: CustomBottomNavBar(
                selectedIndex: state,
              ),
              body: getPage(state),
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
        return const HomeView();
      case 3:
        return const HomeView();
      case 4:
        return const HomeView();
      default:
        return const HomeView();
    }
  }
}
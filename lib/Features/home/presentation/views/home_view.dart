import 'package:fazakir/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimesCubit()..initPrayerTime(),
      child: const SafeArea(child: HomeViewBody()),
    );
  }
}

import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_times_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimesCubit()..initPrayerTime(),
      child: const SafeArea(
        child: PrayerTimesViewBody(),
      ),
    );
  }
}

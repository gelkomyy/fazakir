import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_times_view_body.dart';
import 'package:flutter/material.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: PrayerTimesViewBody(),
    );
  }
}

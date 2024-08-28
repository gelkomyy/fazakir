import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_details_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTimesColumn extends StatelessWidget {
  const PrayerTimesColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: context
              .read<PrayerTimesCubit>()
              .prayerList
              .map(
                (e) => PrayerDetailsBar(
                  prayerEntity: e,
                  isNextPrayer:
                      context.read<PrayerTimesCubit>().nextPrayerName ==
                              e.prayer.name
                          ? true
                          : false,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

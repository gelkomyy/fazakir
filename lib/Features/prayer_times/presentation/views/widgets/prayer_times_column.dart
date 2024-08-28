import 'package:adhan/adhan.dart';
import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_details_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimesColumn extends StatefulWidget {
  const PrayerTimesColumn({
    super.key,
  });

  @override
  State<PrayerTimesColumn> createState() => _PrayerTimesColumnState();
}

class _PrayerTimesColumnState extends State<PrayerTimesColumn> {
  @override
  void initState() {
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        context.read<PrayerTimesCubit>().editPrayerTimes(
              PrayerTimes(
                Coordinates(locationData.latitude, locationData.longitude),
                DateComponents.from(DateTime.now()),
                CalculationMethod.egyptian.getParameters(),
              ),
            );
      } else {}
    });

    super.initState();
  }

  Future<Position?> getLocationData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, so return null
      return null;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permission is still denied, return null
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return null;
    }

    // If all permissions are granted, get the location data
    return await Geolocator.getCurrentPosition();
  }

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

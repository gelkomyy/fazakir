import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:fazakir/Features/prayer_times/domain/entities/prayer_entity.dart';
import 'package:fazakir/core/enums/prayer_enum.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit() : super(PrayerTimesInitial());

  static PrayerTimes prayerTimes = PrayerTimes(
    Coordinates(30.04444, 31.23583),
    DateComponents.from(DateTime.now()),
    CalculationMethod.egyptian.getParameters(),
  );

  static Prayer nextPrayer = prayerTimes.nextPrayer();
  DateTime? nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);

  String get nextPrayerName => nextPrayer.name;

  PrayerTimes get getPrayerTimes => prayerTimes;

  List<PrayerEntity> prayerList = [
    PrayerEntity(
      prayer: PrayerEnum.fajr,
      time: DateFormat.jm().format(prayerTimes.fajr),
    ),
    PrayerEntity(
      prayer: PrayerEnum.sunrise,
      time: DateFormat.jm().format(prayerTimes.sunrise),
    ),
    PrayerEntity(
      prayer: PrayerEnum.dhuhr,
      time: DateFormat.jm().format(prayerTimes.dhuhr),
    ),
    PrayerEntity(
      prayer: PrayerEnum.asr,
      time: DateFormat.jm().format(prayerTimes.asr),
    ),
    PrayerEntity(
      prayer: PrayerEnum.maghrib,
      time: DateFormat.jm().format(prayerTimes.maghrib),
    ),
    PrayerEntity(
      prayer: PrayerEnum.isha,
      time: DateFormat.jm().format(prayerTimes.isha),
    ),
  ];

  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      nextPrayer = prayerTimes.nextPrayer();
      nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);
      safeEmit(PrayerTimesInitial()); // Emit the updated state every minute
    });
  }

  void stopTimer() {
    _timer?.cancel(); // Stop the timer when no longer needed
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel the timer when the Cubit is closed
    return super.close();
  }

  editPrayerTimes(PrayerTimes newPrayerTimes) {
    if ((newPrayerTimes.coordinates.latitude ==
                prayerTimes.coordinates.latitude &&
            newPrayerTimes.coordinates.longitude ==
                prayerTimes.coordinates.longitude) &&
        newPrayerTimes.dateComponents == prayerTimes.dateComponents) return;
    safeEmit(PrayerTimesLoading());
    prayerTimes = newPrayerTimes;
    nextPrayer = prayerTimes.nextPrayer();
    nextPrayerTime = prayerTimes.timeForPrayer(nextPrayer);
    prayerList = [
      PrayerEntity(
        prayer: PrayerEnum.fajr,
        time: DateFormat.jm().format(prayerTimes.fajr),
      ),
      PrayerEntity(
        prayer: PrayerEnum.sunrise,
        time: DateFormat.jm().format(prayerTimes.sunrise),
      ),
      PrayerEntity(
        prayer: PrayerEnum.dhuhr,
        time: DateFormat.jm().format(prayerTimes.dhuhr),
      ),
      PrayerEntity(
        prayer: PrayerEnum.asr,
        time: DateFormat.jm().format(prayerTimes.asr),
      ),
      PrayerEntity(
        prayer: PrayerEnum.maghrib,
        time: DateFormat.jm().format(prayerTimes.maghrib),
      ),
      PrayerEntity(
        prayer: PrayerEnum.isha,
        time: DateFormat.jm().format(prayerTimes.isha),
      ),
    ];
    safeEmit(PrayerTimesLoaded());
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

  void initPrayerTime() {
    getLocationData().then((locationData) {
      if (locationData != null) {
        editPrayerTimes(
          PrayerTimes(
            Coordinates(locationData.latitude, locationData.longitude),
            DateComponents.from(DateTime.now()),
            CalculationMethod.egyptian.getParameters(),
          ),
        );
      } else {}
    });

    startTimer();
  }
}

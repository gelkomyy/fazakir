import 'package:adhan/adhan.dart';
import 'package:fazakir/Features/prayer_times/domain/entities/prayer_entity.dart';
import 'package:fazakir/core/enums/prayer_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  editPrayerTimes(PrayerTimes newPrayerTimes) {
    if ((newPrayerTimes.coordinates.latitude ==
                prayerTimes.coordinates.latitude &&
            newPrayerTimes.coordinates.longitude ==
                prayerTimes.coordinates.longitude) &&
        newPrayerTimes.dateComponents == prayerTimes.dateComponents) return;
    emit(PrayerTimesLoading());
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
    emit(PrayerTimesLoaded());
  }
}

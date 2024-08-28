import 'package:fazakir/core/utils/app_assets.dart';

enum PrayerEnum { sunrise, fajr, dhuhr, asr, maghrib, isha }

extension PrayerEnumExtension on PrayerEnum {
  String get arabicName {
    switch (this) {
      case PrayerEnum.sunrise:
        return 'الشروق';
      case PrayerEnum.fajr:
        return 'الفجر';
      case PrayerEnum.dhuhr:
        return 'الظهر';
      case PrayerEnum.asr:
        return 'العصر';
      case PrayerEnum.maghrib:
        return 'المغرب';
      case PrayerEnum.isha:
        return 'العشاء';
    }
  }

  String get englishName {
    switch (this) {
      case PrayerEnum.sunrise:
        return 'Sunrise';
      case PrayerEnum.fajr:
        return 'Fajr';
      case PrayerEnum.dhuhr:
        return 'Dhuhr';
      case PrayerEnum.asr:
        return 'Asr';
      case PrayerEnum.maghrib:
        return 'Maghrib';
      case PrayerEnum.isha:
        return 'Isha';
    }
  }

  String get iconSVGPath {
    switch (this) {
      case PrayerEnum.sunrise:
        return Assets.assetsImagesFajrIconSvg;
      case PrayerEnum.fajr:
        return Assets.assetsImagesFajrIconSvg;
      case PrayerEnum.dhuhr:
        return Assets.assetsImagesDhuhrIconSvg;
      case PrayerEnum.asr:
        return Assets.assetsImagesAsrIconSvg;
      case PrayerEnum.maghrib:
        return Assets.assetsImagesMaghribIconSvg;
      case PrayerEnum.isha:
        return Assets.assetsImagesIshaIconSvg;
    }
  }
}

PrayerEnum getPrayerEnumByName(String name) {
  switch (name.toLowerCase()) {
    case 'sunrise':
      return PrayerEnum.sunrise;
    case 'fajr':
      return PrayerEnum.fajr;
    case 'dhuhr':
      return PrayerEnum.dhuhr;
    case 'asr':
      return PrayerEnum.asr;
    case 'maghrib':
      return PrayerEnum.maghrib;
    case 'isha':
      return PrayerEnum.isha;
    default:
      throw ArgumentError('Unknown prayer name: $name');
  }
}

import 'package:adhan/adhan.dart';
import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:fazakir/core/enums/prayer_enum.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemainTimeForNextPrayerText extends StatelessWidget {
  const RemainTimeForNextPrayerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        final PrayerTimes prayerTimes =
            context.read<PrayerTimesCubit>().getPrayerTimes;
        final PrayerEnum? nextPrayer = getPrayerEnumByName(
          context.read<PrayerTimesCubit>().nextPrayerName,
        );
        final Duration? remainTime = context
            .read<PrayerTimesCubit>()
            .nextPrayerTime
            ?.difference(DateTime.now());
        if (remainTime == null) {
          context.read<PrayerTimesCubit>().editPrayerTimes(
                PrayerTimes(
                  prayerTimes.coordinates,
                  DateComponents.from(DateTime.now().add(
                    const Duration(days: 1),
                  )),
                  prayerTimes.calculationParameters,
                ),
              );
          return Text(
            'لم يتم معرفة الصلاة القادمة.',
            style: AppFontStyles.styleRegular14(context),
          );
        }
        final int hours = remainTime.inHours;
        final int minutes = remainTime.inMinutes.remainder(60);
        String formattedTime = '';

        /*  if (hours > 0) {
          formattedTime += '$hours hour${hours > 1 ? 's' : ''} ';
        }

        if (minutes > 0) {
          formattedTime += '$minutes minute${minutes > 1 ? 's' : ''}';
        } */

        if (hours > 0) {
          formattedTime += getArabicHourString(hours);
        }
        if (hours > 0 && minutes > 0) {
          formattedTime += ' و ';
        }
        if (minutes > 0) {
          formattedTime += getArabicMinuteString(minutes);
        }

        if (formattedTime.isEmpty) {
          if (nextPrayer == PrayerEnum.sunrise) {
            formattedTime = 'الشروق الآن.';
          } else {
            formattedTime = 'الصلاة الآن.';
          }
        } else {
          if (nextPrayer == null) {
            formattedTime = 'لم يتم معرفة الصلاة القادمة.';
          } else if (nextPrayer == PrayerEnum.sunrise) {
            formattedTime = '${nextPrayer.arabicName} بعد $formattedTime.';
          } else {
            formattedTime = 'صلاة ${nextPrayer.arabicName} بعد $formattedTime.';
          }
        }
        return Text(
          formattedTime,
          style: AppFontStyles.styleRegular14(context),
        );
      },
    );
  }

  String getArabicHourString(int hours) {
    if (hours == 1) return 'ساعة';
    if (hours == 2) return 'ساعتين';
    if (hours >= 3 && hours <= 10) return '$hours ساعات';
    return '$hours ساعة';
  }

  String getArabicMinuteString(int minutes) {
    if (minutes == 1) return 'دقيقة';
    if (minutes == 2) return 'دقيقتين';
    if (minutes >= 3 && minutes <= 10) return '$minutes دقائق';
    return '$minutes دقيقة';
  }
}

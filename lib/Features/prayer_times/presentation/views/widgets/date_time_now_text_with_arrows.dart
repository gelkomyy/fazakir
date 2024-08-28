import 'package:adhan/adhan.dart';
import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';

class DateTimeNowTextWithArrows extends StatefulWidget {
  const DateTimeNowTextWithArrows({
    super.key,
  });

  @override
  State<DateTimeNowTextWithArrows> createState() =>
      _DateTimeNowTextWithArrowsState();
}

class _DateTimeNowTextWithArrowsState extends State<DateTimeNowTextWithArrows> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final PrayerTimes prayerTimes =
        context.read<PrayerTimesCubit>().getPrayerTimes;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Bounceable(
            scaleFactor: 0.5,
            onTap: () {
              date = date.add(const Duration(days: 1));
              context.read<PrayerTimesCubit>().editPrayerTimes(
                    PrayerTimes(
                      prayerTimes.coordinates,
                      DateComponents.from(date),
                      prayerTimes.calculationParameters,
                    ),
                  );
              setState(() {});
            },
            child: const Icon(Icons.arrow_back_outlined,
                color: AppColors.primaryColor)),
        const SizedBox(width: 24),
        Text(
          DateFormat.yMEd().format(date),
          style: AppFontStyles.styleBold15(context)
              .copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(width: 24),
        Bounceable(
            scaleFactor: 0.5,
            onTap: () {
              date = date.subtract(const Duration(days: 1));
              context.read<PrayerTimesCubit>().editPrayerTimes(
                    PrayerTimes(
                      prayerTimes.coordinates,
                      DateComponents.from(date),
                      prayerTimes.calculationParameters,
                    ),
                  );
              setState(() {});
            },
            child: const Icon(Icons.arrow_forward_outlined,
                color: AppColors.primaryColor)),
      ],
    );
  }
}

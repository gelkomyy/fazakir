import 'package:fazakir/Features/prayer_times/presentation/domain/entities/prayer_entity.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_details_bar.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_times_view_body_header.dart';
import 'package:fazakir/core/enums/prayer_enum.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrayerTimesViewBody extends StatelessWidget {
  const PrayerTimesViewBody({super.key});
  static const List<PrayerEntity> prayerList = [
    PrayerEntity(
      prayer: PrayerEnum.fajr,
      time: '5:00',
    ),
    PrayerEntity(
      prayer: PrayerEnum.dhuhr,
      time: '12:00',
    ),
    PrayerEntity(
      prayer: PrayerEnum.asr,
      time: '15:00',
    ),
    PrayerEntity(
      prayer: PrayerEnum.maghrib,
      time: '18:00',
    ),
    PrayerEntity(
      prayer: PrayerEnum.isha,
      time: '19:00',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: SvgPicture.asset(
            Assets.assetsImagesPrayerTimesBackgroundShapeSvg,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 62,
              ),
              const PrayerTimesViewBodyHeader(),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: prayerList
                      .map(
                        (e) => PrayerDetailsBar(
                          prayerEntity: e,
                          isNextPrayer:
                              e.prayer == PrayerEnum.asr ? true : false,
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

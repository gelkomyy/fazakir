import 'package:fazakir/Features/prayer_times/presentation/views/widgets/date_time_now_text_with_arrows.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_times_column.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/prayer_times_view_body_header.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrayerTimesViewBody extends StatelessWidget {
  const PrayerTimesViewBody({super.key});

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
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              PrayerTimesViewBodyHeader(),
              SizedBox(
                height: 12,
              ),
              DateTimeNowTextWithArrows(),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: PrayerTimesColumn(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

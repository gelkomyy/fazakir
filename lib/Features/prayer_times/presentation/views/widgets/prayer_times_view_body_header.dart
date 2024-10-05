import 'package:fazakir/Features/prayer_times/presentation/views/qiblah_view.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class PrayerTimesViewBodyHeader extends StatelessWidget {
  const PrayerTimesViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.26,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesPrayerBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Colors.transparent, Colors.black],
          ),
        ),
        child: Column(
          children: [
            Text(
              'لمعرفة أقرب مسجد',
              style: AppFontStyles.styleBold15(context).copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Bounceable(
              scaleFactor: 0.6,
              onTap: () {
                openLink(
                    'https://www.google.com/maps/search/?api=1&query=mosques+near+me');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySwatch.shade800,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'اقرب مسجد',
                      style: AppFontStyles.styleBold14(context).copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Icon(
                      Icons.pin_drop_outlined,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              'لمعرفة القبلة',
              style: AppFontStyles.styleBold15(context).copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Bounceable(
              scaleFactor: 0.6,
              onTap: () {
                Navigator.pushNamed(context, QiblahView.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySwatch.shade800,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'القبلة',
                      style: AppFontStyles.styleBold14(context).copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Icon(
                      Icons.explore_outlined,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

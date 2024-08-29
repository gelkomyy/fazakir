import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class QiblahCompassBottom extends StatelessWidget {
  const QiblahCompassBottom(
      {super.key, required this.qiblahDirection, required this.direction});
  final double qiblahDirection;
  final double direction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'تحرك مع السهم',
                style: AppFontStyles.styleRegular16(context),
              ),
              TextSpan(
                text: ' الاحمر ',
                style: AppFontStyles.styleBold16(context).copyWith(
                  color: AppColors.redColor,
                ),
              ),
              TextSpan(
                text: 'لتعرف زاوية قبلة الصلاة',
                style: AppFontStyles.styleRegular16(context),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'زاوية القبلة : ${qiblahDirection.toInt()}°',
              style: AppFontStyles.styleRegular14(context),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
              color: AppColors.greyColor,
              height: 10,
              width: 1,
            ),
            Text(
              showHeading(direction, qiblahDirection),
              style: AppFontStyles.styleBold16(context).copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  String showHeading(double direction, double qiblaDirection) {
    return qiblaDirection.toInt() != direction.toInt()
        ? 'الزاوية الحالية :  ${direction.toStringAsFixed(0)}°'
        : S.current.correct_qibla;
  }
}

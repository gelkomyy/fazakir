import 'package:fazakir/Features/prayer_times/domain/entities/prayer_entity.dart';
import 'package:fazakir/core/enums/prayer_enum.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrayerDetailsBar extends StatelessWidget {
  const PrayerDetailsBar({
    super.key,
    required this.prayerEntity,
    this.isNextPrayer = false,
  });
  final PrayerEntity prayerEntity;
  final bool isNextPrayer;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: ShapeDecoration(
        color: isNextPrayer ? AppColors.primaryColor : const Color(0x51BBBBBB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            prayerEntity.prayer.iconSVGPath,
            width: 24,
            colorFilter: ColorFilter.mode(
              isNextPrayer ? Colors.white : AppColors.textBlackColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            prayerEntity.prayer.arabicName,
            textAlign: TextAlign.right,
            style: AppFontStyles.styleBold14(context).copyWith(
              color: isNextPrayer ? Colors.white : null,
            ),
          ),
          const Spacer(),
          Text(
            prayerEntity.time,
            textAlign: TextAlign.right,
            style: AppFontStyles.styleBold14(context).copyWith(
              color: isNextPrayer ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}

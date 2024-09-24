import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/Features/sebha/presentation/views/sebha_view.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/edit_zikr_dialog.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class SebhaZikrItem extends StatelessWidget {
  const SebhaZikrItem({
    super.key,
    required this.zikr,
  });

  final SebhaZikrModel zikr;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Bounceable(
          scaleFactor: 0.5,
          onTap: () {
            showEditZikrDialog(context, zikr);
          },
          child: SvgPicture.asset(
            Assets.assetsImagesEditIconSvg,
            width: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        Bounceable(
          onTap: () {
            Navigator.pushNamed(context, SebhaView.routeName, arguments: zikr);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(
              top: 10,
              end: 22,
              start: 10,
              bottom: 10,
            ),
            decoration: ShapeDecoration(
              color: const Color(0x51BBBBBB),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  zikr.zikr,
                  style: AppFontStyles.styleBold14(context),
                ),
                Text(
                  zikr.count.toString(),
                  style: AppFontStyles.styleRegular14(context)
                      .copyWith(color: AppColors.primarySwatch.shade400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

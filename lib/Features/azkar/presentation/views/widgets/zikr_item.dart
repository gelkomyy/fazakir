import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/Features/azkar/presentation/views/zikr_view.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class ZikrItem extends StatelessWidget {
  const ZikrItem({
    super.key,
    required this.azkarCategory,
  });

  final AzkarCategoryEntity azkarCategory;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.pushNamed(
          context,
          ZikrView.routeName,
          arguments: azkarCategory,
        );
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              azkarCategory.category,
              textAlign: TextAlign.right,
              style: AppFontStyles.styleRegular14(context),
            ),
            const Icon(
              Icons.arrow_forward_outlined,
              color: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class TextWithArrowContainer extends StatelessWidget {
  const TextWithArrowContainer(
      {super.key, required this.text, required this.onTap});
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
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
              text,
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

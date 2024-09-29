import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class CustomSelectContainer extends StatelessWidget {
  const CustomSelectContainer({
    super.key,
    required this.active,
    required this.text,
    this.borderRadius,
    this.activeColor = Colors.white,
    this.textColor,
    this.activeTextColor,
    this.milliseconds = 200,
  });

  final bool active;
  final String text;
  final BorderRadiusGeometry? borderRadius;
  final Color activeColor;
  final Color? textColor, activeTextColor;
  final int milliseconds;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: milliseconds),
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
          color: active ? activeColor : null,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(12))),
      child: Center(
        child: Text(
          text,
          style: AppFontStyles.styleRegular16(context)
              .copyWith(color: active ? activeTextColor : textColor),
        ),
      ),
    );
  }
}

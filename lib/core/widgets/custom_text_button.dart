import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    this.padding = const EdgeInsets.all(12),
    required this.onPressed,
    this.textStyle,
  });
  final String text;
  final Color backgroundColor;
  final OutlinedBorder shape;
  final EdgeInsetsGeometry padding;
  final void Function() onPressed;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: shape,
        padding: padding,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ??
            AppFontStyles.styleBold14(context).copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

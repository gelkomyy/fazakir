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
    this.minimumSize = const Size(double.infinity, 24),
    required this.onPressed,
    this.textStyle,
    this.textColor = Colors.white,
    this.child,
  });
  final String text;
  final Color backgroundColor, textColor;
  final OutlinedBorder shape;
  final EdgeInsetsGeometry padding;
  final void Function() onPressed;
  final TextStyle? textStyle;
  final Size? minimumSize;

  /// if passed child, all text options ignore.
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: shape,
        padding: padding,
        minimumSize: minimumSize,
      ),
      onPressed: onPressed,
      child: child ??
          Text(
            text,
            style: textStyle ??
                AppFontStyles.styleBold14(context).copyWith(
                  color: textColor,
                ),
          ),
    );
  }
}

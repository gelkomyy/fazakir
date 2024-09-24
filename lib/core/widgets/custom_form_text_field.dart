import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.initialValue,
  });
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      initialValue: initialValue,
      keyboardType: keyboardType,
      inputFormatters: keyboardType == TextInputType.number
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      cursorColor: AppColors.primaryColor,
      style: AppFontStyles.styleRegular13(context),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        hintText: hintText,
        hintStyle: AppFontStyles.styleRegular13(context).copyWith(
          color: AppColors.greyColor,
        ),
        filled: true,
        fillColor: Colors.white,
        border: getBorder(),
        enabledBorder: getBorder(),
      ),
    );
  }

  OutlineInputBorder getBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}

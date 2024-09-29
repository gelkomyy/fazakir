import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.enabled,
      this.focusNode,
      this.onChanged});
  final String hintText;
  final bool? enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      enabled: enabled,
      cursorColor: AppColors.primaryColor,
      style: AppFontStyles.styleRegular14(context),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        hintText: hintText,
        hintStyle: AppFontStyles.styleRegular11(context).copyWith(
          color: AppColors.greyColor,
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SvgPicture.asset(
            Assets.assetsImagesSearchIconSvg,
            width: 16,
            height: 16,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 12,
          minWidth: 12,
        ),
        border: getBorder(),
        enabledBorder: getBorder(),
      ),
    );
  }

  OutlineInputBorder getBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    );
  }
}

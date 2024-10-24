import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PageNumberOfQuranWidget extends StatelessWidget {
  const PageNumberOfQuranWidget({
    super.key,
    required this.pageNumber,
  });
  final int pageNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surahHeaderFrameColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: Center(
        child: Text(
          pageNumber.toArabicDigits(),
          style: const TextStyle(
            fontFamily: "Scheherazade",
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

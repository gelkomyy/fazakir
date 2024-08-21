import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class CustomShortCutImageShape extends StatelessWidget {
  const CustomShortCutImageShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.72,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF6F5B42),
              blurRadius: 24,
              offset: Offset(0, 4),
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesQuranImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Colors.transparent, Colors.black],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                'القران الكريم',
                style: AppFontStyles.styleBold10(context).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

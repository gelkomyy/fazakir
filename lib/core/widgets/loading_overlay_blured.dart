import 'dart:ui';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_font_styles.dart';

class LoadingOverlayBlured extends StatelessWidget {
  const LoadingOverlayBlured({
    super.key,
    required this.child,
    required this.isLoading,
    this.blurEffectIntensity = 1.3,
  });

  final Widget child;
  final bool isLoading;
  final double blurEffectIntensity;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AbsorbPointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaX: blurEffectIntensity, sigmaY: blurEffectIntensity),
                  child: child,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primarySwatch.shade50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.greyColor.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 10),
                    Text('Loading...',
                        style: AppFontStyles.styleBold16(context)),
                  ],
                ),
              )
            ],
          )
        : child;
  }
}

import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class SurahHeaderFrame extends StatelessWidget {
  final int surahNumber;

  const SurahHeaderFrame({
    super.key,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.surahHeaderFrameColor,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              Assets.assetsImagesSurahFrame,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: surahNumber.toString(),
                  style: AppFontStyles.styleRegular28(context)
                      .copyWith(fontFamily: "arsura", color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

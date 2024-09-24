import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class RemainingCountWithResetButton extends StatelessWidget {
  const RemainingCountWithResetButton({
    super.key,
    required this.remainingCount,
    required this.zikrCount,
    required this.currentCount,
  });

  final ValueNotifier<int> remainingCount;
  final int zikrCount;
  final ValueNotifier<int> currentCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            minimumSize: null,
            padding: const EdgeInsets.all(14),
            backgroundColor: AppColors.textBlackColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            onPressed: () {
              remainingCount.value = zikrCount;
              currentCount.value = 0;
            },
            text: 'اعادة',
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            decoration: const BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: remainingCount,
              builder: (context, value, child) {
                if (value == 0) {
                  try {
                    HapticFeedback.mediumImpact();
                  } catch (e) {
                    SystemSound.play(SystemSoundType.alert);
                  }
                  Vibration.hasCustomVibrationsSupport().then(
                    (value) {
                      if (value == true) {
                        Vibration.vibrate(duration: 1000);
                      } else {
                        Vibration.vibrate();
                        Future.delayed(
                          const Duration(milliseconds: 500),
                        ).then(
                          (value) {
                            Vibration.vibrate();
                          },
                        );
                      }
                    },
                  );
                }
                return Text(
                  '$value',
                  style: AppFontStyles.styleBold15(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

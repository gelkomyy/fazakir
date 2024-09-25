import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SebhaCircleWithCurrentCount extends StatelessWidget {
  const SebhaCircleWithCurrentCount({
    super.key,
    required this.remainingCount,
    required this.currentCount,
  });

  final ValueNotifier<int> remainingCount;
  final ValueNotifier<int> currentCount;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        if (remainingCount.value > 0) {
          SystemSound.play(SystemSoundType.click);
          currentCount.value++;
          remainingCount.value--;
        } else {
          SystemSound.play(SystemSoundType.click);
          currentCount.value++;
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        height: MediaQuery.sizeOf(context).height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 3,
          ),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
              offset: Offset(0, 1),
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(
                flex: 4,
              ),
              ValueListenableBuilder<int>(
                  valueListenable: currentCount,
                  builder: (context, value, child) {
                    return Text(
                      '$value',
                      textAlign: TextAlign.center,
                      style: AppFontStyles.styleRegular70(context).copyWith(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
              const Spacer(
                flex: 3,
              ),
              Text(
                'اضغط داخل الدائرة للتسبيح',
                textAlign: TextAlign.center,
                style: AppFontStyles.styleRegular13(context).copyWith(),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

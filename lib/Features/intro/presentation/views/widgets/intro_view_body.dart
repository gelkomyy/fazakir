import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class IntroViewBody extends StatelessWidget {
  const IntroViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final S txt = S.of(context);
    return Padding(
      padding: const EdgeInsets.all(62),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            txt.light_journey_begins_here,
            textAlign: TextAlign.center,
            style: AppFontStyles.styleBold14(context).copyWith(
              color: AppColors.greyColor,
              fontFamily: 'Almarai',
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.13),
          CustomTextButton(
            text: txt.app_name,
            textStyle: AppFontStyles.styleBold14(context).copyWith(
              color: Colors.white,
              fontFamily: 'Almarai',
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

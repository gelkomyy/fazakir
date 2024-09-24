import 'package:fazakir/Features/sebha/presentation/views/widgets/add_zikr_dialog.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class EmptyZikrStateWidget extends StatelessWidget {
  const EmptyZikrStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'قم بإضافة اذكار لبدء التسبيح',
          style: AppFontStyles.styleBold20(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 24),
        CustomTextButton(
          onPressed: () {
            showAddZikrDialog(context);
          },
          text: 'اضافة ذكر',
        )
      ],
    );
  }
}

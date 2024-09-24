import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class SebhaViewBody extends StatelessWidget {
  const SebhaViewBody({super.key, required this.zikrModel});
  final SebhaZikrModel zikrModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'عدد المرات : ${zikrModel.count}',
          textAlign: TextAlign.center,
          style: AppFontStyles.styleBold20(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

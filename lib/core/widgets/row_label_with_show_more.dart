import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class RowLabelWithShowMore extends StatelessWidget {
  const RowLabelWithShowMore({
    super.key,
    required this.labelText,
    this.showMoreText,
  });
  final String labelText;
  final String? showMoreText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelText,
          style: AppFontStyles.styleBold13(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        Text(
          showMoreText ?? S.of(context).show_all,
          style: AppFontStyles.styleRegular13(context).copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}

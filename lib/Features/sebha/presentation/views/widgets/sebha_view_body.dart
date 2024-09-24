import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/remaining_count_with_reset_button.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/sebha_circle_with_current_count.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class SebhaViewBody extends StatefulWidget {
  const SebhaViewBody({super.key, required this.zikrModel});
  final SebhaZikrModel zikrModel;

  @override
  State<SebhaViewBody> createState() => _SebhaViewBodyState();
}

class _SebhaViewBodyState extends State<SebhaViewBody> {
  final ValueNotifier<int> remainingCount = ValueNotifier<int>(0);
  final ValueNotifier<int> currentCount = ValueNotifier<int>(0);
  @override
  void initState() {
    remainingCount.value = widget.zikrModel.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'عدد المرات : ${widget.zikrModel.count}',
          textAlign: TextAlign.center,
          style: AppFontStyles.styleBold20(context).copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        const Spacer(),
        RemainingCountWithResetButton(
            remainingCount: remainingCount,
            zikrCount: widget.zikrModel.count,
            currentCount: currentCount),
        const SizedBox(height: 24),
        SebhaCircleWithCurrentCount(
            remainingCount: remainingCount, currentCount: currentCount),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

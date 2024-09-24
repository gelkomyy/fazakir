import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

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
        const Spacer(),
        Padding(
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
                onPressed: () {},
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
                child: Text(
                  '${zikrModel.count}',
                  style: AppFontStyles.styleBold15(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Bounceable(
          onTap: () {},
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: MediaQuery.sizeOf(context).height * 0.5,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
                width: 3,
              ),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.primaryColor,
                  blurRadius: 12,
                  offset: Offset(0, 2),
                  spreadRadius: 1,
                ),
              ],
              image: const DecorationImage(
                image: AssetImage(
                  Assets.assetsImagesIslamicBackgroundPatternVector,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Text(
                    '${zikrModel.count}',
                    textAlign: TextAlign.center,
                    style: AppFontStyles.styleRegular70(context).copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
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
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/Features/sebha/presentation/manager/cubits/manage_sebha_zikr_cubit/manage_sebha_zikr_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:fazakir/core/widgets/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EditZikrDialog extends StatelessWidget {
  const EditZikrDialog({super.key, required this.zikr});
  final SebhaZikrModel zikr;
  @override
  Widget build(BuildContext context) {
    final manageCubit = context.read<ManageSebhaZikrCubit>();
    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.assetsImagesEditIconSvg,
            width: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'تعديل ذكر',
            style: AppFontStyles.styleBold16(context),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 210, 210, 210),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      actions: [
        CustomTextButton(
          text: 'تعديل الذكر',
          onPressed: () {
            manageCubit.formKeyEdit.currentState!.save();
            if (manageCubit.formKeyEdit.currentState!.validate()) {
              manageCubit.updateSebhaZikr(
                zikr.id,
                zikr.copyWith(
                  zikr: manageCubit.editZikr,
                  count: manageCubit.editZikrCount,
                ),
              );
              Navigator.pop(context);
            }
          },
        ),
        CustomTextButton(
          backgroundColor: AppColors.redColor,
          text: 'حذف الذكر',
          onPressed: () {
            manageCubit.deleteSebhaZikr(zikr.id);
            Navigator.pop(context);
          },
        )
      ],
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: manageCubit.formKeyEdit,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormTextField(
                initialValue: zikr.zikr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال الذكر';
                  }
                  return null;
                },
                onSaved: (value) {
                  manageCubit.editZikr = value;
                },
                hintText: 'اكتب الذكر',
              ),
              const SizedBox(height: 24),
              CustomFormTextField(
                initialValue: zikr.count.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال عدد المرات';
                  }
                  return null;
                },
                onSaved: (value) {
                  manageCubit.editZikrCount = int.tryParse(value ?? '1f');
                },
                keyboardType: TextInputType.number,
                hintText: 'عدد المرات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showEditZikrDialog(BuildContext context, SebhaZikrModel zikr) {
  showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: context.read<ManageSebhaZikrCubit>(),
      child: EditZikrDialog(
        zikr: zikr,
      ),
    ),
  );
}

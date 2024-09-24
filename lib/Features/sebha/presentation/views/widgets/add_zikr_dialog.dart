import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:fazakir/core/widgets/custom_form_text_field.dart';
import 'package:flutter/material.dart';

class AddZikrDialog extends StatelessWidget {
  const AddZikrDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add_outlined,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            'اضافة ذكر',
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
          text: 'إضافة الذكر',
          onPressed: () {},
        ),
      ],
      content: const SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormTextField(
              hintText: 'اكتب الذكر',
            ),
            SizedBox(height: 24),
            CustomFormTextField(
              keyboardType: TextInputType.number,
              hintText: 'عدد المرات',
            ),
          ],
        ),
      ),
    );
  }
}

void showAddZikrDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AddZikrDialog(),
  );
}

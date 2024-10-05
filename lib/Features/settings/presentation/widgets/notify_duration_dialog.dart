import 'package:fazakir/Features/settings/presentation/widgets/notify_duration_dialog_content.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotifyDurationDialog extends StatelessWidget {
  const NotifyDurationDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 0,
      ),
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
          const SizedBox(width: 6),
          Text(
            'تحديد الميعاد',
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
      content: const SizedBox(
        width: double.maxFinite,
        child: NotifyDurationDialogContent(),
      ),
    );
  }
}

void showNotifyDurationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const NotifyDurationDialog(),
  );
}

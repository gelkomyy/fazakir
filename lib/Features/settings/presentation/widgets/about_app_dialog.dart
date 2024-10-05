import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.assetsImagesAppIcon,
            width: 24,
          ),
          const SizedBox(width: 6),
          Text(
            'عن التطبيق',
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
      content: SizedBox(
        width: double.maxFinite,
        child: Text(
          'هو تطبيق إسلامي شامل.. يوفر مجموعة واسعة من الميزات الدينية والروحانية للمستخدمين المسلمين. يتميز التطبيق بواجهة سهلة الاستخدام وتصميم جذاب، ويقدم مجموعة متنوعة من الميزات التي تجعله أداة مفيدة للمستخدمين من جميع الأعمار والمستويات الدينية.',
          style: AppFontStyles.styleRegular16(context),
        ),
      ),
    );
  }
}

void showAboutAppDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const AboutAppDialog(),
  );
}

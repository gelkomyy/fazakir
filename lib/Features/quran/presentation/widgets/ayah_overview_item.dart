import 'package:fazakir/Features/quran/domain/entities/ayah_entity.dart';
import 'package:fazakir/Features/quran/presentation/views/quran_pages_view.dart';
import 'package:fazakir/Features/quran/presentation/widgets/quran_text_highlighter.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/g_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class AyahOverviewItem extends StatelessWidget {
  const AyahOverviewItem({
    super.key,
    required this.ayahEntity,
  });

  final AyahEntity ayahEntity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      visualDensity: const VisualDensity(
        horizontal: -4,
        vertical: -4,
      ),
      tileColor: AppColors.greyColor2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      title: Text(
        "${ayahEntity.surahName} : ${ayahEntity.ayahNumber.toArabicDigits()}",
        style: AppFontStyles.styleBold20(context).copyWith(
          fontFamily: 'Scheherazade',
        ),
      ),
      subtitle: QuranTextHighlighter(
        query: ayahEntity.query,
        ayah: ayahEntity.ayah,
        mainStyle: AppFontStyles.styleRegular18(context).copyWith(
          color: AppColors.primaryColor,
          fontFamily: 'Amiri',
          height: 2.2,
        ),
        highlightColor: Colors.red, // Highlight color of your choice
      ),

      /*  Text(
        ayahEntity.ayah,
        style: AppFontStyles.styleRegular18(context).copyWith(
          color: AppColors.primaryColor,
          fontFamily: 'Scheherazade',
        ),
      ) ,*/
      trailing: Bounceable(
        onTap: () {
          Clipboard.setData(
            ClipboardData(
                text:
                    '${ayahEntity.ayah} \n [${ayahEntity.surahName} : ${ayahEntity.ayahNumber.toArabicDigits()}]'),
          ).then(
            (_) {
              if (!context.mounted) return;
              showCustomSnackBar(context, 'تم النسخ');
            },
          );
        },
        child: SvgPicture.asset(
          Assets.assetsImagesCopyIconSvg,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.greyColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      /*  const Icon(
        Icons.arrow_forward_outlined,
        color: AppColors.greyColor,
      ), */
      onTap: () {
        Navigator.pushNamed(
          context,
          QuranPagesView.routeName,
          arguments: {
            'highlightVerse': ayahEntity.ayah,
            'shouldHighlightText': true,
            'pageNumber': ayahEntity.pageNumber,
          },
        );
      },
    );
  }
}

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/ahadith/presentation/views/widgets/components_of_hadith_item.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class ContainerHadithItem extends StatelessWidget {
  const ContainerHadithItem({
    super.key,
    required this.hadithEntity,
  });
  final HadithEntity hadithEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.greyColor.withOpacity(0.32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                hadithEntity.bookName,
                textAlign: TextAlign.right,
                style: AppFontStyles.styleBold12(context)
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 12,
              end: 12,
              bottom: 12,
              top: 0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Text(
                  hadithEntity.hadith,
                  textAlign: TextAlign.center,
                  style: AppFontStyles.styleRegular24(context).copyWith(
                    fontFamily: 'Scheherazade',
                  ),
                ),
                const SizedBox(height: 6),
                Card(
                  color: AppColors.greyColor,
                  child: Column(
                    children: [
                      Text(
                        '${hadithEntity.bookName} - ${hadithEntity.sectionOfBookHadith} \n الصفحة أو الرقم : ${hadithEntity.hadithNumber}',
                        textAlign: TextAlign.center,
                        style: AppFontStyles.styleRegular24(context).copyWith(
                          fontFamily: 'Scheherazade',
                        ),
                      ),
                      if (hadithEntity.grades.isNotEmpty)
                        Text(
                          '${hadithEntity.grades.first['grade']} ${(hadithEntity.grades.first['graded_by'] != null && hadithEntity.grades.first['graded_by'] != '') ? '[${hadithEntity.grades.first['graded_by']}] ' : ''}',
                          textAlign: TextAlign.center,
                          style: AppFontStyles.styleRegular24(context).copyWith(
                            fontFamily: 'Scheherazade',
                            color: AppColors.primaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ComponentsOfHadithItem(
                  hadithEntity: hadithEntity,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/page_number_quran_overview_item.dart';
import 'package:fazakir/Features/quran/presentation/widgets/quran_juz_overview_item.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class PagesAndJuzzQuranSearch extends StatelessWidget {
  const PagesAndJuzzQuranSearch({
    super.key,
    required this.quranCubit,
  });

  final QuranCubit quranCubit;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: quranCubit.ayat.length,
      itemBuilder: (BuildContext context, int index) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) ...[
                  Text(
                    'الصفحات'
                    ' (${quranCubit.ayat.length})',
                    style: AppFontStyles.styleBold16(context),
                  ),
                  const SizedBox(height: 12),
                ],
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 16,
                  ),
                  child: PageNumberQuranOverviewItem(
                      queryNum: quranCubit.ayat.first.queryNum!),
                ),
                if (quranCubit.ayat.first.queryNum! <= 30) ...[
                  Text(
                    'الأجزاء'
                    ' (${quranCubit.ayat.length})',
                    style: AppFontStyles.styleBold16(context),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 16,
                    ),
                    child: QuranJuzOverviewItem(
                        juzNumber: quranCubit.ayat.first.queryNum!),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}

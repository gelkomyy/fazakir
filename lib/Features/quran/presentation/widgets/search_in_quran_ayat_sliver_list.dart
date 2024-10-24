import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/ayah_overview_item.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class SearchInQuranAyatSliverList extends StatelessWidget {
  const SearchInQuranAyatSliverList({
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
                    'الآيات'
                    ' (${quranCubit.ayat.length})',
                    style: AppFontStyles.styleBold16(context),
                  ),
                  const SizedBox(height: 12),
                ],
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 16,
                  ),
                  child: AyahOverviewItem(ayahEntity: quranCubit.ayat[index]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

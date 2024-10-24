import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/filtered_surahs_sliver_list.dart';
import 'package:fazakir/Features/quran/presentation/widgets/pages_and_juzz_quran_search.dart';
import 'package:fazakir/Features/quran/presentation/widgets/search_in_quran_ayat_sliver_list.dart';
import 'package:fazakir/Features/quran/presentation/widgets/search_in_quran_loading_widget.dart';
import 'package:fazakir/Features/quran/presentation/widgets/surahs_loading_widget.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is SurahsLoaded ||
              state is SearchInQuranLoaded ||
              state is SearchInQuranLoading) {
            QuranCubit quranCubit = context.read<QuranCubit>();
            if (quranCubit.filteredSurahs.isEmpty &&
                quranCubit.ayat.isEmpty &&
                state is! SearchInQuranLoading) {
              return Center(
                child: Text(
                  'لا توجد نتائج',
                  style: AppFontStyles.styleBold20(context).copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                FilteredSurahsSliverList(quranCubit: quranCubit),
                if (quranCubit.ayat.isNotEmpty &&
                    quranCubit.ayat.first.queryNum != null)
                  PagesAndJuzzQuranSearch(quranCubit: quranCubit),
                if (state is SearchInQuranLoading)
                  SearchInQuranLoadingWidget(quranCubit: quranCubit),
                if (quranCubit.ayat.isNotEmpty &&
                    quranCubit.ayat.first.queryNum == null)
                  SearchInQuranAyatSliverList(quranCubit: quranCubit),
              ],
            );
          } else if (state is SurahsFailure || state is SearchInQuranFailure) {
            return Center(
              child: Text((state is SurahsFailure
                  ? state.errMessage
                  : (state as SearchInQuranFailure).errMessage)),
            );
          } else {
            return SurahsLoadingWidget();
          }
        },
      ),
    );
  }
}

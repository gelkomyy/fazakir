import 'package:fazakir/Features/ahadith/presentation/manager/cubits/hadith_processing_cubit/hadith_processing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.context) : super(SearchInitial());
  final BuildContext context;
  // Method to handle search across both Hadith and Zikr entities
  Future<void> searchContent(String searchQuery) async {
    emit(SearchLoading());

    try {
      final hadithResults = await context
          .read<HadithProcessingCubit>()
          .filterHadiths(searchQuery);

      // Search Zikr
      /*  final zikrResults = await Isolate.run(() {
        return allAzkar.where((zikrEntity) {
          final normalizedZikr = removeDiacritics(zikrEntity.zikr);
          return normalizedZikr.contains(normalizedSearch);
        }).toList();
      }); */

      emit(SearchLoaded(hadithResults));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}

import 'dart:async';

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/quran/data/repos/quran_repo_impl.dart';
import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(this.quranRepoImpl) : super(QuranInitial());
  final QuranRepoImpl quranRepoImpl;
  List<SurahEntity> surahs = [];
  List<SurahEntity> filteredSurahs = [];
  Timer? _debounce;
  Future<void> fetchSurahs() async {
    try {
      safeEmit(SurahsLoading());
      surahs = await quranRepoImpl.fetchSurahs();
      filteredSurahs = surahs;
      safeEmit(SurahsLoaded(surahs: filteredSurahs));
    } catch (e) {
      safeEmit(
        const SurahsFailure(errMessage: 'Failed to load surahs'),
      );
    }
  }

  void filterSurahsWithDebounce(String query) {
    // Cancel any active debounced call
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set a delay of 300ms before triggering the filtering function
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _filterSurahs(query);
    });
  }

  // Filter Surahs by title
  void _filterSurahs(String query) {
    if (query.isEmpty) {
      filteredSurahs = surahs;
    } else {
      filteredSurahs = surahs.where((video) {
        final normalizedQuery =
            normalizeArabicText(removeDiacritics(query.toLowerCase()));
        final normalizedTitle =
            normalizeArabicText(removeDiacritics(video.name.toLowerCase()));
        return normalizedTitle.contains(normalizedQuery);
      }).toList();
    }

    // Emit success state with filtered Surahs
    safeEmit(SurahsLoaded(surahs: filteredSurahs));
  }

  @override
  Future<void> close() {
    // Cancel the debounce timer when the cubit is closed
    _debounce?.cancel();
    return super.close();
  }
}

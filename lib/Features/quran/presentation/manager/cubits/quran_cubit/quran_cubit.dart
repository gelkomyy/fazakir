import 'dart:async';
import 'dart:developer';

import 'package:fazakir/Features/quran/data/repos/quran_repo_impl.dart';
import 'package:fazakir/Features/quran/domain/entities/ayah_entity.dart';
import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/quran.dart' as quran;
import 'package:string_validator/string_validator.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(this.quranRepoImpl) : super(QuranInitial());
  final QuranRepoImpl quranRepoImpl;
  List<SurahEntity> surahs = [];
  List<SurahEntity> filteredSurahs = [];
  List<AyahEntity> ayat = [];
  Timer? _debounce;
  Timer? _isolateDebounce;
  String? _lastQuery;
  Future<void> fetchSurahs() async {
    try {
      safeEmit(SurahsLoading());
      surahs = await quranRepoImpl.fetchSurahs();
      filteredSurahs = surahs;
      safeEmit(SurahsLoaded(surahs: filteredSurahs));
    } catch (e) {
      safeEmit(
        const SurahsFailure('Failed to load surahs'),
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
      filteredSurahs = surahs.where((surah) {
        query = query.toEnglishDigits();
        if (isInt(query) && toInt(query) < 605 && toInt(query) > 0) {
          return surah.number == toInt(query);
        }

        /* query = query.replaceAll('سورة ', '');
        query = query.replaceAll('سورة', '');
        query = query.replaceAll('سوره ', '');
        query = query.replaceAll('سوره', ''); */
        final normalizedQuery = removeTashkeels(query);
        final normalizedTitle = removeTashkeels(surah.name);
        return normalizedTitle.contains(normalizedQuery);
      }).toList();
    }

    // Emit success state with filtered Surahs
    safeEmit(SurahsLoaded(surahs: filteredSurahs));
  }

  /// Debounced search in Quran using compute
  void searchInQuranWithIsolateDebounce(String query) {
    // Cancel any active debounced call
    if (_isolateDebounce?.isActive ?? false) {
      _isolateDebounce!.cancel();
    }

    // Set a delay of 300ms before triggering the filtering function
    _isolateDebounce = Timer(const Duration(milliseconds: 300), () {
      // Assign the current query as the last query
      _lastQuery = query;
      // Perform the search only after debouncing
      _searchInQuranWithCompute(query);
    });
  }

  /// Start searching in a separate thread using compute
  void _searchInQuranWithCompute(String query) async {
    // Before starting a new search, clear the previous results
    ayat = [];
    if (query.isEmpty) {
      safeEmit(SearchInQuranLoaded(ayat: ayat));
      return;
    }
    safeEmit(SearchInQuranLoading());
    query = query.toEnglishDigits();

    if (isInt(query) && toInt(query) < 605 && toInt(query) > 0) {
      ayat.add(
        AyahEntity(
          ayahNumber: 1,
          surahNumber: 1,
          query: '',
          queryNum: toInt(query),
        ),
      );

      safeEmit(SearchInQuranLoaded(ayat: ayat));
      return;
    }
    // Execute the search function in a separate thread using `compute`
    final List<AyahEntity> result = await compute(_searchInQuran, query);

    // Check if the query has changed during the debounce. If yes, discard this result.
    if (query != _lastQuery) {
      log('Query changed; discarding result for: $query');
      return;
    }

    // If the result is for the latest query, use it
    ayat = result;
    safeEmit(SearchInQuranLoaded(ayat: ayat));
  }

  /// Heavy search logic to be performed in the background
  static List<AyahEntity> _searchInQuran(String query) {
    List<AyahEntity> ayat = [];

    // Simulate heavy search task (quran.searchWords)
    final ayatFiltered = quran.searchWords(query);

    if ((ayatFiltered["result"])?.isEmpty ?? true) {
      log('No ayat found');
    } else {
      for (var element in (ayatFiltered["result"] as List)) {
        final ayahNumber = element["verse"];
        final surahNumber = element["surah"];
        ayat.add(
          AyahEntity(
              ayahNumber: ayahNumber, surahNumber: surahNumber, query: query),
        );
      }
    }
    return ayat;
  }

  @override
  Future<void> close() {
    // Cancel the debounce timer when the cubit is closed
    _debounce?.cancel();
    _isolateDebounce?.cancel();
    return super.close();
  }
}

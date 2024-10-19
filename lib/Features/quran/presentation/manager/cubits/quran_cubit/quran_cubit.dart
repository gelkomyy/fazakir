import 'dart:async';
import 'dart:developer';

import 'package:fazakir/Features/quran/data/repos/quran_repo_impl.dart';
import 'package:fazakir/Features/quran/domain/entities/ayah_entity.dart';
import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:fazakir/core/extensions/number_converter.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  void searchInQuranWithIsolateDebounce(String query) {
    // Cancel any active debounced call
    if (_isolateDebounce?.isActive ?? false) _isolateDebounce!.cancel();

    // Set a delay of 300ms before triggering the filtering function
    _isolateDebounce = Timer(const Duration(milliseconds: 300), () {
      _searchInQuran(query);
    });
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

  void _searchInQuran(String query) {
    if (query.isEmpty) {
      ayat = [];
      safeEmit(SearchInQuranLoaded(ayat: ayat));
      return;
    }
    final ayatFiltered = quran.searchWords(query);
    if ((ayatFiltered["result"])?.isEmpty ?? true) {
      log('No ayat found');
      ayat = [];
    } else {
      for (var element in (ayatFiltered["result"] as List)) {
        final ayahNumber = element["verse"];
        final surahNumber = element["surah"];
        ayat.add(
          AyahEntity(
              ayahNumber: ayahNumber, surahNumber: surahNumber, query: query),
        );
      }

      /*  final verseNumber = ayatFiltered["result"][0]["verse"];
      final surahNumber = ayatFiltered["result"][0]["surah"];

      final verse =
          quran.getVerse(surahNumber, verseNumber, verseEndSymbol: true);

      final surahName = quran.getSurahNameArabic(surahNumber);
      log("$surahName : ${(verseNumber as num).toArabicDigits()}  \n - $verse"); */
      //log('\n ${ayatFiltered["result"]} ');
    }
    safeEmit(SearchInQuranLoaded(ayat: ayat));
  }

  @override
  Future<void> close() {
    // Cancel the debounce timer when the cubit is closed
    _debounce?.cancel();
    _isolateDebounce?.cancel();
    return super.close();
  }
}

import 'dart:isolate';

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/ahadith/presentation/views/widgets/ahadith_view_body.dart';
import 'package:fazakir/core/extensions/manage_hadiths_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hadith/hadith.dart';

part 'hadith_processing_state.dart';

class HadithProcessingCubit extends Cubit<HadithProcessingState> {
  HadithProcessingCubit() : super(HadithProcessingInitial());

  List<HadithEntity> _allAhadith = [];

  List<HadithEntity> get allAhadith => _allAhadith;

  Future<void> processHadiths() async {
    emit(HadithProcessingLoading());

    try {
      // Fetch book names in the main thread (lightweight operation)
      final a6BooksOfHadiths = ManageHadithsExtensions.getDisplayNames();

      // Use a Future.wait to parallelize fetching for different books
      List<Future<List<HadithEntity>>> hadithFutures = [];

      for (String bookName in a6BooksOfHadiths) {
        hadithFutures.add(_fetchHadithForBook(bookName));
      }

      // Wait for all hadiths to be fetched in parallel
      final results = await Future.wait(hadithFutures);

      // Combine all results into a single list
      _allAhadith = results.expand((list) => list).toList();

      emit(HadithProcessingLoaded(_allAhadith));
    } catch (e) {
      emit(HadithProcessingError(e.toString()));
    }
  }

  // Fetch hadiths for a single book using isolates for heavier tasks
  Future<List<HadithEntity>> _fetchHadithForBook(String bookName) async {
    // Fetch sections in isolate (heavy task)
    final sectionsOfBookHadith = await Isolate.run(
        () => getBooks(ManageHadithsExtensions.getCollectionByName(bookName)));

    List<HadithEntity> bookHadiths = [];

    for (int index = 0; index < sectionsOfBookHadith.length; index++) {
      final sectionOfBookHadithNumber =
          _getSectionNumber(bookName, sectionsOfBookHadith[index].bookNumber);

      // Fetch ahadith in isolate (heavy task)
      final ahadith = await Isolate.run(() => getHadiths(
          ManageHadithsExtensions.getCollectionByName(bookName),
          sectionOfBookHadithNumber));

      // Convert to HadithEntity
      bookHadiths.addAll(ahadith.map((hadith) => HadithEntity(
            hadith: parseHadith(hadith.hadith[1].body),
            bookName: bookName,
            sectionOfBookHadith: getBook(
                    ManageHadithsExtensions.getCollectionByName(bookName),
                    int.parse(hadith.bookNumber))
                .book[1]
                .name,
            hadithNumber: hadith.hadithNumber,
            grades: hadith.hadith[1].grades,
          )));
    }

    return bookHadiths;
  }

  int _getSectionNumber(String bookName, String bookNumber) {
    if (bookName == 'سنن ابن ماجه' || bookName == 'صحيح مسلم') {
      final parsedNumber = int.tryParse(bookNumber);
      return parsedNumber == null ? 1 : parsedNumber + 1;
    }
    return int.parse(bookNumber);
  }

  // Method to filter hadiths efficiently
  Future<List<HadithEntity>?> filterHadiths(String searchHadith) async {
    // Run the filter operation in an isolate to avoid UI freezing
    return await Isolate.run(() {
      if (searchHadith.isEmpty || _allAhadith.isEmpty) return null;

      final searchTerms =
          HadithEntity.removeDiacritics(searchHadith).toLowerCase().split(' ');
      return _allAhadith.where((hadith) {
        return searchTerms.every((term) =>
            hadith.hadithWithoutTashkeel.toLowerCase().contains(term));
      }).toList();
    });
  }
}

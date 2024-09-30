import 'dart:developer';
import 'dart:isolate';

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/ahadith/presentation/views/widgets/ahadith_view_body.dart';
import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:fazakir/core/extensions/manage_hadiths_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'hadith_processing_state.dart';

class HadithProcessingCubit extends Cubit<HadithProcessingState> {
  HadithProcessingCubit() : super(HadithProcessingInitial()) {
    _loadHadithFromIsar();
    // Load data from Isar on cubit creation
  }

  List<HadithEntity> _allAhadith = [];

  List<HadithEntity> get allAhadith => _allAhadith;

  // Load hadiths from Isar
  Future<void> _loadHadithFromIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    // Open the Isar instance
    final Isar isar =
        await Isar.open([HadithEntitySchema], directory: dir.path);

    try {
      // Retrieve all HadithEntity records
      _allAhadith = await isar.hadithEntitys.where().findAll();

      if (_allAhadith.isNotEmpty) {
        emit(HadithProcessingLoaded(
            _allAhadith)); // Emit loaded state with data from Isar
      }
    } catch (e) {
      log('Error loading hadiths from Isar: $e');
      emit(HadithProcessingError('Failed to load hadiths from database.'));
    } finally {
      await isar.close(); // Close the Isar instance
    }
  }

  // Save the hadiths to Isar
  Future<void> _saveHadithToIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    // Open the Isar instance
    final Isar isar =
        await Isar.open([HadithEntitySchema], directory: dir.path);

    try {
      await isar.writeTxn(() async {
        await isar.hadithEntitys
            .putAll(_allAhadith); // Save all HadithEntity records
      });
    } catch (e) {
      log('Error saving hadiths to Isar: $e');
    } finally {
      await isar.close(); // Close the Isar instance
    }
  }

  Future<void> processHadiths() async {
    emit(HadithProcessingLoading());

    if (_allAhadith.isNotEmpty) {
      // Hadiths are already loaded from shared preferences, no need to process
      emit(HadithProcessingLoaded(_allAhadith));
      return;
    }
    try {
      List<List<HadithEntity>> results = await processTheHadiths();
      _allAhadith = results.expand((list) => list).toList();

      emit(HadithProcessingLoaded(_allAhadith));
      await _saveHadithToIsar();
    } catch (e) {
      emit(HadithProcessingError('Failed to process hadiths.'));
    }
  }

  Future<List<List<HadithEntity>>> processTheHadiths() async {
    final a6BooksOfHadiths = ManageHadithsExtensions.getDisplayNames();

    List<Future<List<HadithEntity>>> hadithFutures = [];
    for (String bookName in a6BooksOfHadiths) {
      hadithFutures.add(_fetchHadithForBook(bookName));
    }

    final results = await Future.wait(hadithFutures);
    return results;
  }

  Future<List<HadithEntity>> _fetchHadithForBook(String bookName) async {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_isolateProcess, {
      'sendPort': receivePort.sendPort,
      'bookName': bookName,
    });

    final List<dynamic> result = await receivePort.first;
    return (result).map((item) => HadithEntity.fromJson(item)).toList();
  }

  static void _isolateProcess(Map<String, dynamic> message) async {
    final SendPort sendPort = message['sendPort'];
    final String bookName = message['bookName'];

    final sectionsOfBookHadith =
        getBooks(ManageHadithsExtensions.getCollectionByName(bookName));
    List<Map<String, dynamic>> processedHadiths = [];

    for (var section in sectionsOfBookHadith) {
      final sectionNumber = _getSectionNumber(bookName, section.bookNumber);
      List<Hadith> ahadith = [];
      try {
        ahadith = getHadiths(
            ManageHadithsExtensions.getCollectionByName(bookName),
            sectionNumber);
      } catch (e) {
        log('Error: $e at --- $bookName:$sectionNumber---');
      }

      for (Hadith hadith in ahadith) {
        processedHadiths.add({
          'hadith': parseHadith(hadith.hadith[1].body),
          'bookName': bookName,
          'sectionOfBookHadith': getBook(
                  ManageHadithsExtensions.getCollectionByName(bookName),
                  int.parse(hadith.bookNumber))
              .book[1]
              .name,
          'hadithNumber': hadith.hadithNumber,
          'grades': hadith.hadith[1].grades,
        });
      }
    }

    sendPort.send(processedHadiths);
  }

  static int _getSectionNumber(String bookName, String bookNumber) {
    if (bookNumber == 'introduction') bookNumber = '1';
    bookNumber = bookNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (bookName == 'سنن ابن ماجه' || bookName == 'صحيح مسلم') {
      final parsedNumber = int.tryParse(bookNumber);

      return parsedNumber ?? 1;
    }

    return int.parse(bookNumber);
  }

  Future<SearchResult> filterHadiths(String searchHadith) async {
    if (searchHadith.isEmpty || _allAhadith.isEmpty) {
      return SearchResult(exactMatches: [], relatedMatches: []);
    }

    return await compute<Map<String, dynamic>, SearchResult>(
      _filterHadithsIsolate,
      {
        'searchHadith': searchHadith,
        'allAhadith': _allAhadith.map((h) => h.toJson()).toList(),
      },
    );
  }

  static SearchResult _filterHadithsIsolate(Map<String, dynamic> params) {
    final String searchHadith = params['searchHadith'];
    final List<Map<String, dynamic>> allAhadithMaps = params['allAhadith'];

    final normalizedQuery =
        normalizeArabicText(removeDiacritics(searchHadith).toLowerCase());
    final searchTerms = normalizedQuery.split(' ');
    final List<HadithEntity> allAhadith =
        allAhadithMaps.map((m) => HadithEntity.fromJson(m)).toList();
    List<HadithEntity> exactMatches = [];
    List<HadithEntity> relatedMatches = [];

    for (HadithEntity hadith in allAhadith) {
      String normalizedHadith =
          normalizeArabicText(hadith.hadithWithoutTashkeel.toLowerCase());

      if (normalizedHadith.contains(normalizedQuery)) {
        exactMatches.add(hadith);
      } else {
        int matchingWordCount = 0;

        for (String term in searchTerms) {
          if (normalizedHadith.contains(term) ||
              hasPartialMatch(term, normalizedHadith)) {
            matchingWordCount++;
          }
        }

        // If a sufficient number of terms match, consider it a related result
        if (matchingWordCount > 0) {
          relatedMatches.add(hadith);
        }
      }
    }

    return SearchResult(
        exactMatches: exactMatches, relatedMatches: relatedMatches);
  }
}

import 'dart:developer';
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
      final a6BooksOfHadiths = ManageHadithsExtensions.getDisplayNames();

      List<Future<List<HadithEntity>>> hadithFutures = [];
      for (String bookName in a6BooksOfHadiths) {
        hadithFutures.add(_fetchHadithForBook(bookName));
      }

      final results = await Future.wait(hadithFutures);
      _allAhadith = results.expand((list) => list).toList();

      emit(HadithProcessingLoaded(_allAhadith));
    } catch (e) {
      emit(HadithProcessingError(e.toString()));
    }
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
      final ahadith = getHadiths(
          ManageHadithsExtensions.getCollectionByName(bookName), sectionNumber);

      for (var hadith in ahadith) {
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
    if (bookName == 'سنن ابن ماجه' || bookName == 'صحيح مسلم') {
      final parsedNumber = int.tryParse(bookNumber);
      log('$bookName : ${parsedNumber == null ? 1 : parsedNumber + 1}');
      return parsedNumber == null ? 1 : parsedNumber + 1;
    }
    return int.parse(bookNumber);
  }

  // Method to filter hadiths efficiently
  Future<List<HadithEntity>?> filterHadiths(String searchHadith) async {
    // Run the filter operation in an isolate to avoid UI freezing

    if (searchHadith.isEmpty || _allAhadith.isEmpty) return null;
    return await Isolate.run<List<HadithEntity>?>(() {
      final searchTerms =
          HadithEntity.removeDiacritics(searchHadith).toLowerCase().split(' ');
      return _allAhadith.where((hadith) {
        return searchTerms.every((term) =>
            hadith.hadithWithoutTashkeel.toLowerCase().contains(term));
      }).toList();
    });
  }
}

import 'package:quran/quran.dart';

class AyahEntity {
  final int ayahNumber;
  late String ayah;
  final int surahNumber;
  late String surahName;
  late int pageNumber;
  final String query;
  num? queryNum;

  AyahEntity({
    required this.ayahNumber,
    required this.surahNumber,
    required this.query,
    this.queryNum,
  }) {
    surahName = getSurahNameArabic(surahNumber);
    pageNumber = getPageNumber(surahNumber, ayahNumber);
    ayah = getVerse(surahNumber, ayahNumber, verseEndSymbol: true);
  }
}

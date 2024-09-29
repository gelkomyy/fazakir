import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';

class HadithEntity extends FavoriteEntity {
  final String hadith;
  final String hadithWithoutTashkeel;
  final String hadithNumber;
  final String bookName;
  final String sectionOfBookHadith;
  final List grades;
  HadithEntity({
    required this.hadith,
    required this.bookName,
    required this.sectionOfBookHadith,
    required this.hadithNumber,
    required this.grades,
  }) : hadithWithoutTashkeel = removeDiacritics(hadith);

  @override
  factory HadithEntity.fromJson(Map<String, dynamic> json) {
    return HadithEntity(
      hadith: json['hadith'],
      bookName: json['bookName'],
      sectionOfBookHadith: json['sectionOfBookHadith'],
      hadithNumber: json['hadithNumber'],
      grades: json['grades'],
    );
  }

  @override
  String getIdentifier() => "hadith-$hadithNumber-$sectionOfBookHadith";

  @override
  Map<String, dynamic> toJson() {
    return {
      'hadith': hadith,
      'bookName': bookName,
      'sectionOfBookHadith': sectionOfBookHadith,
      'hadithNumber': hadithNumber,
      'grades': grades,
    };
  }
}

String removeDiacritics(String input) {
  final RegExp diacriticRegExp = RegExp(
      r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]');
  return input.replaceAll(diacriticRegExp, '');
}
